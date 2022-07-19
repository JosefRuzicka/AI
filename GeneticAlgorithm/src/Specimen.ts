import { Shape, getRandomNumber, Circle, Rectangle } from './Shapes'
export class Specimen {
  canvas: HTMLCanvasElement | null
  shapes: Shape[]
  aptitude: number
  context: CanvasRenderingContext2D | null

  constructor () {
    this.canvas = document.createElement('canvas')
    this.canvas.width = this.canvas.height = 100
    this.context = this.canvas.getContext('2d')
    if (this.context) {
      this.context.font = 'italic 10pt Calibri'
    }

    this.shapes = []
    this.aptitude = 0
  }

  mutate = function (this: Specimen, shapeMutationChance: number, mutationMagitude: number) {
    this.shapes.forEach(shape => {
      shape.mutate(shapeMutationChance, mutationMagitude)
    })
  }
}

// Adapted from https://dev.to/codebubb/how-to-shuffle-an-array-in-javascript-2ikj
export function fischerYatesAlgorithm (shapes: Shape[]) {
  for (let i = shapes.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1))
    const temp = shapes[i]
    shapes[i] = shapes[j]
    shapes[j] = temp
  }
}

// Choose random amount of shapes that would be propagated in crossover from each parent specimen.
// Propagate first 50 (if there are as many) shapes to child specimen.
function Crossover (specimenAlpha: Specimen, specimenBeta: Specimen): Specimen {
  const newSpecimen = new Specimen()
  let newSpecimenShapes = specimenAlpha.shapes
  newSpecimenShapes = newSpecimenShapes.concat(specimenBeta.shapes)
  fischerYatesAlgorithm(newSpecimenShapes)
  newSpecimen.shapes = newSpecimenShapes.slice(0, Math.min(newSpecimenShapes.length, 50))

  return newSpecimen
}

export function generatePopulation (specimenQty: number): Specimen[] {
  const population = []

  for (let index = 0; index < specimenQty; index++) {
    const specimen = new Specimen()
    const nCircles = 50
    // const nRectangles = getRandomNumber(25)

    for (let circle = 0; circle < nCircles; circle++) {
      specimen.shapes.push(new Circle())
    }
 
    // for (let rectangle = 0; rectangle < nRectangles; rectangle++) {
      // specimen.shapes.push(new Rectangle())
    // }

    population.push(specimen)
  }
  return population
}

export function selectSpecimenForCrossing (population: Specimen[]): Specimen[] {
  let selectedSpecimens: Specimen[] = []
  // 80 de los mejores    10 peores
  const bestLastIndex = Math.round(population.length * 0.80)
  const worstBeginIndex = Math.round(population.length * 0.90)

  selectedSpecimens = population.slice(0, bestLastIndex)
  selectedSpecimens = selectedSpecimens.concat(population.slice(worstBeginIndex, population.length))

  return selectedSpecimens
}

export function generateNextGeneration (selectedSpecimens: Specimen[], populationSize: number, specimenMutationChance: number, shapeMutationChance: number, mutationMagnitude: number, population:Specimen[]): void {
  const newGeneration: Specimen[] = []
  for (let newSpecimen = 0; newSpecimen < populationSize; newSpecimen++) {

    const specimen = Crossover(selectedSpecimens[getRandomNumber(selectedSpecimens.length - 1)], selectedSpecimens[getRandomNumber(selectedSpecimens.length - 1)])
    
    if (getRandomNumber(100) <= specimenMutationChance) {
      specimen.mutate(shapeMutationChance, mutationMagnitude)
    }
    population[newSpecimen] = specimen
  }

  //return newGeneration
}

export function similarity (imageData1: ImageData, imageData2: ImageData): number {
  const data2 = imageData2.data
  const data1 = imageData1.data
  let suma = 0
  for (let i = 0; i < data1.length; i += 4) {
    suma += Math.pow((data1[i] - data2[i]), 2)
    suma += Math.pow((data1[i + 1] - data2[i + 1]), 2)
    suma += Math.pow((data1[i + 2] - data2[i + 2]), 2)
  }
  return Math.pow(suma, 1 / 2)
}
