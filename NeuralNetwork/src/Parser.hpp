#ifndef PARSER_HPP
#define PARSER_HPP

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <sstream>

#pragma once
using namespace std;
namespace Parser
{
  void readCSV(std::string path, std::vector<std::vector<double>> &inputs, std::vector<std::vector<std::string>> &categories)
  {
    {
      inputs.clear();
      categories.clear();

      string fname = path;
      vector<string> categoriesRow;
      vector<double> row;
      string line, word;
      fstream file(fname, ios::in);
      if (file.is_open())
      {
        // Este primer getline es para obtener la linea de los nombres de las categorias
        getline(file, line);
        stringstream str(line);
        while (getline(str, word, ';'))
        {
          categoriesRow.push_back(word);
        }
        categories.push_back(categoriesRow);
        // GuardarTodosLos inputs
        while (getline(file, line))
        {
          row.clear();
          stringstream str(line);
          while (getline(str, word, ';'))
          {
            row.push_back(stod(word));
          }
          inputs.push_back(row);
        }
      }
      else
      {
        cout << "Could not open the file\n";
      }
    }
  }

}; // namespace Parser
#endif
