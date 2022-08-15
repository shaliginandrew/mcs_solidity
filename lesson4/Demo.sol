// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;


/*
На основе структур данных создать контракт, который 
1)содержит две структуры 
-Платеж(поля- сумма платежа, время платежа, адрес плательщика, сообщение)и
-Баланс на счете(поля - общее количество платежей и мапа ключ - номер платежа, значение платеж
 и мапу, баланс на конкретном счету, ключ- адрес, значение баланс

2)функция для приема платежей, в которую передаем временное сообщение. 
При поступлении платежа - сохраняем о нем информацию в мапу и сохраняем в блокчейн. 
-сохраняем текущий номер платежа
-если от адреса поступил платеж-увеличиваем число платежей
-объявляем временный платеж
-помещаем временный платеж в мапу и сохраняем в блокчейн
3)получаем платеж из мапы баланс по адресу и номеру
*/
contract Demo {
 
    struct Payment { // Платеж
        uint amount; // Сумма платежа
        uint timestamp;// Время платежа
        address from;// Адрес плательщика
        string message;// Сообщение
    }

    struct Balance { // Баланс на счете
        uint totalPayments; // Общее количество платежей
        // мапа, ключ- номер платежа, значение - платеж(сумма,время,адрес плательщика, сообщение)
        mapping(uint => Payment) payments;

    }

// мапа, баланс на конкретном счету, ключ- адрес, значение баланс
    mapping(address => Balance) public balances;

//функция принимает платежи, при поступлении платежа сохраняем о нем информацию
    function pay(string memory message) public payable {

        //сохраняем текущий номер платежа
        uint paymentNum = balances[msg.sender].totalPayments;
        balances[msg.sender].totalPayments++;//от адреса поступил платеж-увеличиваем число платежей
        
//временный платеж
        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );
//помещаем временнй платеж в мапу и сохраняем в блокчейн
        balances[msg.sender].payments[paymentNum] = newPayment;
    }

// получаем платежи из мапы balances
    function getPayment(address _addr, uint _index) public view returns(Payment memory) {
        return balances[_addr].payments[_index];
    }
// continue

   // Enum
    enum Status { Paid, Delivered, Received }
    Status public currentStatus;

    function paid() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }

    // Array
    // Fixed size:
    uint[3][2] public items;

    function fixedSize() public {
        items = [
            [3,4,5],
            [6,7,8]
        ];
    }

    // Dynamic
    uint[] public items;
    uint public len;
    function dynArr() public {
        items.push(4);
        items.push(5);
        len = items.length;
    }

    function sampleMemory() public view returns(uint[] memory) {
        uint[] memory tempArray = new uint[](10);
        tempArray[0] = 1;
        return tempArray;
    }

    // Byte
    bytes32 public myVar = "test here"; // fixed
    bytes public myDynVar = "test here"; // dynamic
    // 1 --> 32
    // 32 * 8 = 256
    // uint256

    function firstByte() public view returns(bytes1) {
        return myDynVar[0];
    }


}
