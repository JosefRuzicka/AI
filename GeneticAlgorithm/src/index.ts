import { generateNextGeneration, generatePopulation, selectSpecimenForCrossing, similarity, Specimen } from './Specimen'

function main () {
  const specimenQty = 100
  let specimenMutationChance = 5
  let shapesMutationChance = 50
  let mutationMagnitude = 5
  // let generationCount = 1
  const src = 'https://picsum.photos/200/300'
  // const src = '../resources/black.png'
  const img = document.createElement('img') as HTMLImageElement
  const originalImageCanvas = document.getElementById('canvas') as HTMLCanvasElement
  console.log('probando')
  let population:Specimen[]

  const originalImageContext = originalImageCanvas.getContext('2d')
  img.src = src
  img.crossOrigin = 'Anonymous'
  let originalImageData: ImageData

  img.onload = function () {
    if (originalImageContext != null) {
      originalImageContext.drawImage(img, 0, 0)

      originalImageData = originalImageContext.getImageData(0, 0, 100, 100)
      population = generatePopulation(specimenQty)
      updateAptitudes(population, originalImageData)
      renderAllShapes(population, originalImageData)
    } else {
      console.log('Original Image is null')
    }
  }

  function evolve (): void {
      // console.log(generation)
    for (let generation = 0; generation < 1; generation++) {
      population.sort((specimenAlpha, specimenBeta) => (specimenAlpha.aptitude > specimenBeta.aptitude) ? 1 : -1)
      const selectedSpecimens = selectSpecimenForCrossing(population)
      generateNextGeneration(selectedSpecimens, specimenQty, specimenMutationChance, shapesMutationChance, mutationMagnitude, population)
      console.log(generation)
      // updateAptitudes(population, originalImageData)
      renderAllShapes(population, originalImageData)
    }
     //specimenMutationChance = Math.min (0.95, 2)
     shapesMutationChance = Math.max(shapesMutationChance*0.99, 5)
     mutationMagnitude *= 0.9
     //let document.createElement('h1')
     //generationCount++
  }

  const evolveButton = document.getElementById('evolveButton')
  evolveButton ? evolveButton.onclick = evolve : evolveButton.onclick = null
}

main()

function updateAptitudes (specimens: Specimen[], imgData: ImageData) {
  // console.log('Entra a hacer update')
  specimens.forEach(specimen => {
    specimen.shapes.forEach(shape => {
      if (specimen.context != null && specimen.canvas != null) {
        shape.draw(specimen.context)
        const specimenImageData = specimen.context.getImageData(0, 0, 100, 100)
        specimen.aptitude = similarity(imgData, specimenImageData)
      } else {
        console.log('Specimen Canvas is null')
        // console.log(specimen)
      }
    })
  })
  // console.log('Sale de hacer update')
}

function renderAllShapes (specimens: Specimen[], imgData: ImageData) {
  const table = document.getElementById('table') as HTMLTableElement

  let specimenRendered = 0
  let row: HTMLTableRowElement
  specimens.forEach(specimen => {
    if (specimenRendered % 5 === 0) {
      row = table.insertRow(table.rows.length)
    }
    specimen.shapes.forEach(shape => {
      if (specimen.context != null && specimen.canvas != null) {
        shape.draw(specimen.context)
        const specimenImageData = specimen.context.getImageData(0, 0, 100, 100)
        specimen.aptitude = similarity(imgData, specimenImageData)
        specimen.context.fillText(specimen.aptitude.toString(), 10, 95)
        row.appendChild(specimen.canvas)
      } else {
        console.log('Specimen Canvas is null')
        // console.log(specimen)
      }
    })
    specimenRendered++
  })
}
