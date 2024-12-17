import * as fs from 'fs';
let file = fs.readFileSync('Input.txt','utf8');

const parseFile = (file: string): { left: number[], right: number[] } => {
  const lines: string[] = file.split('\n')
  const left: number[] = [];
  const right: number[] = [];
  lines.forEach((line) => {
    const [leftNum, rightNum] = line.split(/\s+/).map(Number);
    left.push(leftNum)
    right.push(rightNum)
  })
  return { left, right };
}

const { left, right }: { left: number[], right: number[] } = parseFile(file);

const sumArray = (arr: number[]): number => {
  return arr.reduce((a, b) => a + b, 0);
}

// Part one
const leftSorted: number[] = left.sort();
const rightSorted: number[] = right.sort();
const distances: number[] = leftSorted.map((n, i) => Math.abs(n - rightSorted[i]))
const total: number = sumArray(distances)
// console.log(total)

type Frequencies = Map<number, number> 
// Part 2
const tallyNumbers = (numbers: number[]): Frequencies => {
  const freqs: Frequencies = new Map();
  numbers.forEach(n => {
    freqs[n] = freqs[n] ? freqs[n] + 1 : 1
  })
  return freqs;
}

const frequencies: Frequencies = tallyNumbers(right);
const similarityScores: number[] = left.map(n => n * (frequencies[n] || 0))
console.log(sumArray(similarityScores))
