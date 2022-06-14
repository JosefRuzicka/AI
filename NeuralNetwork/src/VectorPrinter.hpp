#pragma once
using namespace std;
namespace VectorPrinter
{

  template <class vectorType>
  void printVector(vector<vector<vectorType>> vectorToPrint)
  {
    for (int i = 0; i < vectorToPrint.size(); i++)
    {
      for (int j = 0; j < vectorToPrint[i].size(); j++)
      {
        cout << vectorToPrint[i][j] << " ";
      }
      cout << "\n";
    }
  }

}