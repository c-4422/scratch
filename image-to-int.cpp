/*******************
 * Convert image data to decimal numbers
 * not what I want to do but it turns out
 * there isn't a good way of doing pixel
 * art in terminal
 ******************/

#include <iostream>
#include <iomanip>
#include <fstream>
#include <cstring>
#include <vector>
#include <algorithm>

using namespace std;

typedef struct RGB {
    double r;
    double g;
    double b;
} RGB1;

struct RGB ColorConverter(uint32_t hexValue)
{
  struct RGB rgbColor;
  rgbColor.r = ((hexValue >> 24) & 0xFF);  // Extract the RR byte
  rgbColor.g = ((hexValue >> 16) & 0xFF);  // Extract the GG byte
  rgbColor.b = ((hexValue >> 8) & 0xFF);  // Extract the BB byte

  return rgbColor; 
}

int main () {
    // Read in raw binary and start conditioning it for bash
    ifstream myData("Pixel_art_otter_revised.data", ios::binary);
    uint8_t value;
    uint32_t rgb = 0;
    int i = 0;
    int numPixels = 0;
    vector<uint32_t> rgbValues;

    char buf[sizeof(uint8_t)];
    while (myData.read(buf, sizeof(buf)))
    {
        memcpy(&value, buf, sizeof(value));
        rgb += (static_cast<uint32_t>(value) << (24 - ((i % 4) * 8)));
        if ((i % 4) == 3) {
            vector<uint32_t>::iterator it = find(rgbValues.begin(), rgbValues.end(), rgb);

            //Look for value in vector and if it exists print the index if not push it to the vector
            if (it != rgbValues.end()) {
                cout << distance(rgbValues.begin(), it);
            } else {
                rgbValues.push_back(rgb);
                cout << rgbValues.size() - 1;
            }

            // cout << dec << rgb << " ";
            // cout << hex << rgb << " ";
            if (numPixels != 0 && (numPixels % 30) == 29) {
                cout << "\n";
            } else {
                cout << " ";
            }

            rgb = 0;
            numPixels++;
        }
        i++;
    }

    cout << "\nRGB values:\n";
    for (int j = 0; j < rgbValues.size(); j++) {
        auto parsedRGB = ColorConverter(rgbValues[j]);
        cout << j << "=(R:" << setw(5) << parsedRGB.r << " G:" << setw(5) << parsedRGB.g << " B:" << setw(5) << parsedRGB.b << endl;
    }

    cout << endl << "Total count: " << dec << i << endl;
}