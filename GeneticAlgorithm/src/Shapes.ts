
function getRandomHexColor (): string {
  let hexColor = '#'
  hexColor += Math.floor((Math.random() * 100) + 1)
  hexColor += Math.floor((Math.random() * 100) + 1)
  hexColor += Math.floor((Math.random() * 100) + 1)
  return hexColor
}

export function getRandomNumber (range: number) {
  return Math.floor((Math.random() * range) + 1)
}

export class Shape {
  fillColor: string
  x1: number
  y1: number

  constructor (x1 = getRandomNumber(100), y1 = getRandomNumber(100), fillColor = getRandomHexColor()) {
    this.fillColor = fillColor
    this.x1 = x1
    this.y1 = y1
  }

  draw = (context: CanvasRenderingContext2D) => { }
  mutate = function (shapeMutationChance: number, mutationMagnitude: number) { }
}

export class Circle extends Shape {
  radius: number
  constructor (x1?: number, y1?: number, radius = getRandomNumber(15) + 10, fillColor?: string) {
    super(x1, y1, fillColor)
    this.radius = radius
  }

  draw = (context: CanvasRenderingContext2D) => {
    drawCircle(context, this.x1, this.y1, this.radius, this.fillColor)
  }

  mutate = function (this: Circle, shapeMutationChance: number, mutationMagnitude: number) {
    let sign = 1;
    (getRandomNumber(2) < 1) ? sign = -1 : sign = 1
    // if (getRandomNumber(100) <= shapeMutationChance) {
    //   this.x1 += mutationMagnitude * sign
    //   if (this.x1 < 0) this.x1 = 0
    //   if (this.x1 > 100) this.x1 = 100
    // }
    // if (getRandomNumber(100) <= shapeMutationChance) {
    //   this.y1 += mutationMagnitude * sign
    //   if (this.y1 < 0) this.y1 = 0
    //   if (this.y1 > 100) this.y1 = 100
    // }
    // if (getRandomNumber(100) <= shapeMutationChance) {
    //   this.radius += mutationMagnitude * 0.2 * sign
    //   if (this.radius < 2) (this.radius = 2)
    //   if (this.radius > 15) (this.radius = 10)
    // }

    if (getRandomNumber(100) <= shapeMutationChance) {
    this.fillColor = getRandomHexColor()
      
    }
  }
}

export class Rectangle extends Shape {
  x2: number
  y2: number

  constructor (x1?: number, y1?: number, x2: number = getRandomNumber(100), y2 = getRandomNumber(100), fillColor?: string) {
    super(x1, y1, fillColor)
    this.x2 = x2
    this.y2 = y2
  }

  draw = (context: CanvasRenderingContext2D) => {
    drawRectangle(context, this.x1, this.y1, this.x2, this.y2, this.fillColor)
  }

  mutate = function (this: Rectangle, shapeMutationChance: number, mutationMagnitude: number) {
    if (getRandomNumber(100) <= shapeMutationChance) {
      (getRandomNumber(2) < 1) ? this.x1 += mutationMagnitude : this.x1 -= mutationMagnitude
    }
    if (getRandomNumber(100) <= shapeMutationChance) {
      (getRandomNumber(2) < 1) ? this.y1 += mutationMagnitude : this.y1 -= mutationMagnitude
    }
    if (getRandomNumber(100) <= shapeMutationChance) {
      (getRandomNumber(2) < 1) ? this.x2 += mutationMagnitude : this.x2 -= mutationMagnitude
    }
    if (getRandomNumber(100) <= shapeMutationChance) {
      (getRandomNumber(2) < 1) ? this.y2 += mutationMagnitude : this.y2 -= mutationMagnitude
    }
    if (getRandomNumber(100) <= shapeMutationChance) {
      let numberColor = parseInt(this.fillColor.slice(1), 16) as number
      (getRandomNumber(2) < 1)
        ? numberColor += mutationMagnitude * 5
        : numberColor -= mutationMagnitude * 5
      if (numberColor > 0 && numberColor < 16777216) {
        this.fillColor = `#${numberColor.toString(16)}`
      }
    }
  }
}

function drawRectangle (context: CanvasRenderingContext2D, x1: number, y1: number, x2: number, y2: number, fill: string) {
  context.beginPath()
  context.rect(x1, y1, x2, y2)
  context.fillStyle = fill
  context.fill()
}

function drawLine (context: any, x1: number, y1: number, x2: number, y2: number, lineWidth: number, stroke: any) {
  context.beginPath()
  context.moveTo(x1, y1)
  context.lineTo(x2, y2)
  context.lineWidth = lineWidth
  context.strokeStyle = stroke
  context.stroke()
}

function drawCircle (context: CanvasRenderingContext2D, x: number, y: number, radius: number, fill: any) {
  context.beginPath()
  context.arc(x, y, radius, 0, 2 * Math.PI, false)
  context.fillStyle = fill
  context.fill()
}
