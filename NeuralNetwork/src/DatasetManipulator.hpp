#ifndef DATASETMANIPULATOR_HPP
#define DATASETMANIPULATOR_HPP

#pragma once

namespace DatasetManipulator
{
  vector<vector<double>> extractExpectedValues(vector<vector<double>> &inputs, vector<vector<double>> &expectedValues)
  {
    expectedValues.clear();
    for (int pos = 0; pos < inputs.size(); pos++)
    {
      vector<double> expectedValue;
      expectedValue.push_back(inputs[pos].back());
      inputs[pos].pop_back();
      expectedValues.push_back(expectedValue);
    }
    return expectedValues;
  }

  void normalize(vector<vector<double>> &inputs)
  {
    if (inputs.size() > 1)
    {

      vector<double> maxValues = inputs[0];
      for (size_t row = 1; row < inputs.size(); row++)
      {
        for (size_t categoryIndex = 0; categoryIndex < maxValues.size(); categoryIndex++)
        {
          if (inputs[row][categoryIndex] > maxValues[categoryIndex])
          {
            maxValues[categoryIndex] = inputs[row][categoryIndex];
          }
        }
      }

      for (size_t row = 0; row < inputs.size(); row++)
      {
        for (size_t categoryIndex = 0; categoryIndex < maxValues.size(); categoryIndex++)
        {
          inputs[row][categoryIndex] = inputs[row][categoryIndex] / maxValues[categoryIndex];
        }
      }
    }
    else
    {
      cout << "Vector no se puede normalizar";
    }
  }

};

#endif