abstract contract ENS {
    function resolver(bytes32 node) public virtual view returns (Resolver);
}

abstract contract Resolver {
    function addr(bytes32 node) public virtual view returns (address);
}

abstract contract Crossmint {
    ENS ens = ENS(0x00000000000C2E074eC69A0dFb2997BA6C7d2e1e);

    function resolve(bytes32 node) private view returns(address) {
        Resolver resolver = ens.resolver(node);
        return resolver.addr(node);
    }

    function crossmint(address to) internal virtual;

    function crossmint_external(address to) public payable {
        address crossmint_eth = 0xdAb1a1854214684acE522439684a145E62505233; // fallback for testnets
        if(block.chainid == 1) {
            crossmint_eth = resolve(0xb6be6147f37228cf400a942c1e28fa1bb282fe55f0a0de579edf699666055f55); // crossmint.eth
        }
        require(msg.sender == crossmint_eth, "No access");
        crossmint(to);
    }
}
