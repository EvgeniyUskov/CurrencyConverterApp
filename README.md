# CurrencyConverterApp

Приложение для конвертации валют.
На основном экране расположены два поля для ввода значений для конвертации (из какой и в какую валюту), кнопка «Конвертировать» и два элемента для выбора валют, по нажатию на которые должен открываться новый экран со списком валют и строкой поиска для фильтрации.
При выборе значения в списке экран закрывается и выбранная валюта подставляется на экран конвертации.
После ввода значения в одно из полей и нажатия кнопки «Конвертировать» необходимо
 конвертировать валюту и выводить результат в другое поле.
Также имеется возможность обратной конвертации, т.е. можно ввести значение в поле "В какую валюту" и получить результат конвертации в обратную сторону. Это пример из реальной жизни, когда например мы хотим посмотреть, сколько потребуется рублей для покупки 100 долларов, а не сколько долларов мы получим за введенную сумму рублей.
Если в полях уже имеются данные, то при вводе нового значений в любое поле, противоположное должно очищаться.
Функциональность экранов: Экран конвертации:
 по нажатию на элемент для выбора валюты необходимо открывать новый экран со списком валют и строкой поиска для фильтрации;
 при выборе валюты (Из какой/В какую) символ валюты ($, €, ¥, etc.) или ее буквенное обозначение (USD, EUR, etc.) должны подставляться к соответствующему полю ввода значения для конвертации.
Экран списка валют:
 при открытии экрана необходимо загружать информацию с сервера и показывать индикатор
загрузки;
 при выборе значения в списке валют необходимо передавать выбранную валюту на
экран конвертации;
 строка поиска должна фильтровать полученный от сервера список валют.
