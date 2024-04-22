const { StandardMerkleTree } = require("@openzeppelin/merkle-tree");
const fs = require("fs");

// (1)
const tree = StandardMerkleTree.load(JSON.parse(fs.readFileSync("tree.json", "utf8")));

// (2)
for (const [i, v] of tree.entries()) {
  // switch value below and place your address 
  // 0x22F4441ad6DbD602dFdE5Cd8A38F6CAdE68860b0 to get proof
  if (v[0] === '0x91832Bc473daB70e9490cFC2c268e0Ab293f01d5') {
    // (3)
    const proof = tree.getProof(i);
    console.log('Value:', v);
    console.log('Proof:', proof);
  }
}