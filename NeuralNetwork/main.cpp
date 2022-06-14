#include <iostream>
#include <vector>
#include "./src/NeuralNetwork.hpp"
#include "./src/Parser.hpp"
#include "./src/DatasetManipulator.hpp"
#include <omp.h>
#include <chrono>
#include "./src/VectorPrinter.hpp"
#include "./src/Matrix.hpp"
#include <sstream>
using namespace std;

void saveNetwork(string filename, vector<Matrix> &biases, vector<Matrix> &pesos)
{
  fstream new_file;
  new_file.open(filename, ios::out);

  new_file << "b," << biases.size() << ",\n";

  for (size_t i = 0; i < biases.size(); i++)
  {
    new_file << biases[i].toString();
  }

  new_file << "p," << pesos.size() << ",\n";

  for (size_t i = 0; i < pesos.size(); i++)
  {
    new_file << pesos[i].toString();
  }

  new_file.close();
}

int getChargedVectorsCount(stringstream &str_line)
{
  string word;
  getline(str_line, word, ',');
  getline(str_line, word, ',');
  return stoi(word);
}

Matrix chargeMatrixValues(fstream &file, int rows, int columns)
{
  Matrix matrix(rows, columns);
  string line, word;
  for (int i = 0; i < rows; i++)
  {
    getline(file, line);
    stringstream str(line);
    for (int j = 0; j < columns; j++)
    {
      getline(str, word, ',');
      matrix.data[i][j] = stod(word);
    }
  }
  return matrix;
}

void getChargingMatrixSize(stringstream &str_line, int &rows, int &columns)
{
  string word;
  getline(str_line, word, ',');
  getline(str_line, word, ',');
  rows = stoi(word);
  getline(str_line, word, ',');
  columns = stoi(word);
}

void chargeNetwork(string fileName, vector<Matrix> &biases, vector<Matrix> &pesos)
{
  string line, word;
  int weights_count = 0;
  int biases_count = 0;
  int rows = 0;
  int columns = 0;
  fstream file(fileName, ios::in);
  if (file.is_open())
  {
    getline(file, line);
    stringstream ssline(line);
    biases_count = getChargedVectorsCount(ssline);
    biases.resize(biases_count);
    for (int i = 0; i < biases_count; i++)
    {
      getline(file, line);
      stringstream a(line);
      getChargingMatrixSize(a, rows, columns);
      biases[i] = chargeMatrixValues(file, rows, columns);
    }
  }
  getline(file, line);
  stringstream b(line);
  weights_count = getChargedVectorsCount(b);
  pesos.resize(weights_count);
  for (int i = 0; i < weights_count; i++)
  {
    getline(file, line);
    stringstream c(line);
    getChargingMatrixSize(c, rows, columns);
    pesos[i] = (chargeMatrixValues(file, rows, columns));
  }
  file.close();
}

vector<int> parseStringToIntVec(string strToConvert)
{
  vector<int> resultVec;
  string line, word;

  stringstream str(strToConvert);

  while (getline(str, word, ','))
  {
    resultVec.push_back(stoi(word));
  }

  for (int i = 0; i < resultVec.size(); i++)
  {
    cout << resultVec[i] << endl;
  }

  return resultVec;
}

int main()
{
  vector<vector<double>> values{
      vector<double>{0, 0, 0},
      vector<double>{1, 0, 0},
      vector<double>{1, 1, 0},
      vector<double>{1, 1, 1},
      vector<double>{0, 1, 0},
      vector<double>{0, 1, 1},
      vector<double>{0, 0, 1},
      vector<double>{1, 0, 1},
      // vector<double>{ 0, 0},
      // vector<double>{ 0, 1},
      // vector<double>{ 1, 0},
      // vector<double>{ 1, 1},
  };

  vector<vector<double>> expectedValues{
      vector<double>{0},
      vector<double>{1},
      vector<double>{0},
      vector<double>{1},
      vector<double>{1},
      vector<double>{0},
      vector<double>{1},
      vector<double>{0},
      // vector<double>{0},
      // vector<double>{1},
      // vector<double>{1},
      // vector<double>{0},

  };

  vector<vector<string>> categories;
  vector<int> layers = {100, 120, 110};

  Parser::readCSV("winequality-white.csv", values, categories);
  DatasetManipulator::normalize(values);
  DatasetManipulator::extractExpectedValues(values, expectedValues);

  NeuralNetwork neuralNetwork = NeuralNetwork(layers);
  //chargeNetwork("savedWineNN.txt", neuralNetwork.biases, neuralNetwork.weights);
  vector<double> output;
    std::chrono::steady_clock::time_point begin = std::chrono::steady_clock::now();
  neuralNetwork.fit(values, expectedValues, 2000000);

#pragma omp parallel for default(none) schedule(static) \
    shared(neuralNetwork, ouput) private ()
  for (auto value : values)
  {
    output.push_back(neuralNetwork.predict(value)[0]);
  }
#pragma omp parallel for default(none) schedule(static) \
    shared(output, expectedValues) private ()
    for (size_t index = 0; index < expectedValues.size(); index++)
  {
      cout << expectedValues[index][0] << " neural output: " << output[index] << endl;
  }
    std::chrono::steady_clock::time_point end = std::chrono::steady_clock::now();

    std::cout << "Time difference = " << std::chrono::duration_cast<std::chrono::seconds>(end - begin).count() << "[µs]" << std::endl;
    //std::cout << "Time difference = " << std::chrono::duration_cast<std::chrono::nanoseconds> (end - begin).count() << "[ns]" << std::endl;
    //saveNetwork("savedWineNN.txt", neuralNetwork.biases, neuralNetwork.weights);
}
// Imprimir cosas cargadas
// cout << "biases" << endl;
// for (int i = 0; i < neuralNetwork.biases.size(); i++)
// {

//   neuralNetwork.biases[i].printMatrix();
//   cout << i << endl;
// }
// cout << "weights" << endl;
// for (int i = 0; i < neuralNetwork.weights.size(); i++)
// {
//   neuralNetwork.weights[i].printMatrix();
//   cout << i << endl;
// }

// }  // for (auto value : values)
// {

//   output.push_back(neuralNetwork.predict(value)[0]);

//   //
// }

// for (size_t index = 0; index < expectedValues.size(); index++)
// {
//   cout << expectedValues[index][0] << " neural output: " << output[index] << endl;
//}
//  // Menu
//   vector<int> layers = {10};
//   NeuralNetwork neuralNetwork = NeuralNetwork(layers);
//   vector<double> output;
//   int inputFromUser;
//   string inputNeuronsLayers;
//   vector<int> newLayers;
//   vector<vector<string>> categories;
//   int epochs;

//   cout << "Menu" << endl;
//   cout << "1. Utilizar red precargada" << endl;
//   cout << "2. Crear una nueva red " << endl;
//   cout << "Seleccione la opcion deseada:";
//   cin >> inputFromUser;

//   switch (inputFromUser)
//   {
//   case 1:
//     chargeNetwork("savedWineNN.txt", neuralNetwork.biases, neuralNetwork.weights);

//     break;
//   case 2:
//     cout << "Ingrese la cantidad de neuronas por capa oculta que desea crear FORMATO = '7,5,4'" << endl;
//     cin >> inputNeuronsLayers;
//     newLayers = parseStringToIntVec(inputNeuronsLayers);

//     NeuralNetwork newNeuralNetwork = NeuralNetwork(newLayers);
//     Parser::readCSV("trainData.csv", values, categories);
//     DatasetManipulator::normalize(values);
//     DatasetManipulator::extractExpectedValues(values, expectedValues);

//     cout << "Ingrese la cantidad de epocas:";
//     cin >> epochs;
//     newNeuralNetwork.fit(values, expectedValues, epochs);

//     Parser::readCSV("predictData.csv", values, categories);
//     DatasetManipulator::normalize(values);
//     DatasetManipulator::extractExpectedValues(values, expectedValues);
//     for (auto value : expectedValues)
//     {

//       cout << value[0] << " aaa" << endl;
//     }
//     for (auto value : values)
//     {

//       output.push_back(newNeuralNetwork.predict(value)[0]);
//     }

//     for (size_t index = 0; index < expectedValues.size(); index++)
//     break;
//     {
//       cout << "Expected: " << expectedValues[index][0] << " neural output : " << output[index] << endl;
//     }
//   }
