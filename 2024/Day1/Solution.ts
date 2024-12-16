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
const leftSorted: number[] = left.sort();
const rightSorted: number[] = right.sort();
const distances: number[] = leftSorted.map((n, i) => Math.abs(n - rightSorted[i]))
const total: number = distances.reduce((a, b) => a + b, 0)
console.log(total)