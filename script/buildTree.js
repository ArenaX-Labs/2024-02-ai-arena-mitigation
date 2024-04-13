const { StandardMerkleTree } = require("@openzeppelin/merkle-tree");
const fs = require("fs");

// (1)
const values = [
  ["0x22F4441ad6DbD602dFdE5Cd8A38F6CAdE68860b0", "1000000000000000000"],
  ["0x91832Bc473daB70e9490cFC2c268e0Ab293f01d5", "1000000000000000000"]
];

// (2)
const tree = StandardMerkleTree.of(values, ["address", "uint256"]);

// (3)
console.log('Merkle Root:', tree.root);

// (4)
fs.writeFileSync("tree.json", JSON.stringify(tree.dump()));