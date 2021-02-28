pragma solidity >=0.5.0 <0.8.0;

contract Storage {
    struct Item {
        string passphrase;
        string data;
    }

    mapping(string => Item) List;

    event DataSaved(string passphrase, string data);

    function get(string memory passphrase) public view returns (string memory) {
        Item memory _List = List[passphrase];

        return _List.data;
    }

    function set(string memory passphrase, string memory data) public {
        List[passphrase] = Item(passphrase, data);

        emit DataSaved(passphrase, data);
    }
}
