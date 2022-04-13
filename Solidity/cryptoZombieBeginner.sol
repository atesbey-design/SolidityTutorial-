
//Solidity kullanmak için güncel bir versiyon tanımladık. Bu versiyon ile compailer yapılabilecek minimum aralığı da belirtmiş oluyoruz.
pragma solidity ^0.8.13;


//Bir contract yapısı tanımladık
contract ZombieFactory {
    //frontend tarafında etkileşim sağlamak adına bir event tanımladık.
    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
//Struct tanımladık. 
    struct Zombie {
        string name;
        uint dna;
    }
//zombies adında bir array tanımlayarak tipini Zombi struct'ına verdik 
    Zombie[] public zombies;
/*fonksiyon tanımladık. Fonksiyon tanımlarken şu hususlara dikkat edilmeli:


1-Private fonksiyon sadece sahibi tarafından erişime açıktır. Yapılan işin ticari boyutu olduğu için her zaman fonksiyonları private tanımlayıp duruma göre public yapmanızı öneririm.
2-Public fonksiyon her kullanıcı tarafından erişime açıktır. Defalut değer olarak gelir.
3-View görünür işlemlerde durumu değiştirmemeyi sağlar.Şayet bir durum değişikliği oluyorsa uyarı verir.
4-Returns değer döndermek için kullanılır.
  */  function _createZombie(string _name, uint _dna) private {
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string _str) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }

    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}