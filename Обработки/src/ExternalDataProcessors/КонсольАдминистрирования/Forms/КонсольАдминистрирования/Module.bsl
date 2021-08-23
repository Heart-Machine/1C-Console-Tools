#Область ОписаниеПеременных

&НаКлиенте
Перем ОбновитьИнтерфейс;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Параметры.Свойство("АвтоТест") Тогда
		Возврат;
	КонецЕсли;
	
	Обработка = РеквизитФормыВЗначение("Объект");
	Команды.Найти("ИнформацияОСоздателе").Заголовок = Обработка.ПолучитьВерсиюОбратотки();
		
КонецПроцедуры

&НаКлиенте
Процедура ПриЗакрытии(ЗавершениеРаботы)
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	ОбновитьИнтерфейсПрограммы();
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОткрытьФормуОбработки(Команда, ПараметрыОткрытия = Неопределено)
	
	ОткрытьФорму(Лев(ЭтотОбъект.ИмяФормы, СтрНайти(ЭтотОбъект.ИмяФормы, ".", НаправлениеПоиска.СКонца)) + Команда.Имя, ПараметрыОткрытия);

КонецПроцедуры // ОткрытьФормуОбработки()

&НаКлиенте
Процедура ЗаполнитьАдресаПоПредставлению(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ИсправлениеФИОКонтактныхЛиц(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура Копирование_сс_РегистрацияСтатусов(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура Изменение_сс_РегистрацииСтатусов(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ИзменениеРеализацииПеревозкиАвтотранспортом(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ПоискИУдалениеДублей(Команда)
	ОткрытьФорму("Обработка.ПоискИУдалениеДублей.Форма",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ПрофилиГруппДоступа(Команда)
	ОткрытьФорму("Справочник.ПрофилиГруппДоступа.ФормаСписка",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура УчетныеЗаписиЭлектроннойПочты(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ГрупповоеИзменениеРеквизитов(Команда)
	ОткрытьФорму("Обработка.ГрупповоеИзменениеРеквизитов.Форма",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ГрупповоеПерепроведениеДокументов(Команда)
	ОткрытьФорму("Обработка.ГрупповоеПерепроведениеДокументов.Форма",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОбновлениеДанныхИКлассификаторов(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура УправлениеСпискомПользователей(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ПолнотекстовыйПоискВДанных(Команда)
	ОткрытьФорму("Обработка.ПолнотекстовыйПоискВДанных.Форма.УправлениеПолнотекстовымПоискомИИзвлечениемТекстов",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ОткрытьБазуПодДругимПользователем(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура УдалениеПомеченныхОбъектов(Команда)
	ОткрытьФорму("Обработка.УдалениеПомеченныхОбъектов.Форма",,ЭтотОбъект);
КонецПроцедуры

&НаКлиенте
Процедура ДатыЗапретаИзмененияДанных(Команда)
	ОткрытьФорму("РегистрСведений.ДатыЗапретаИзменения.Форма.ДатыЗапретаИзменения");
КонецПроцедуры

&НаКлиенте
Процедура ПерсональныеНастройки(Команда)
	ОткрытьФорму("ОбщаяФорма.ПерсональныеНастройки"); 
КонецПроцедуры

&НаКлиенте
Процедура НастройкиПользователейИПрав(Команда)
	ОткрытьФорму("Обработка.ПанельАдминистрированияБСП.Форма.НастройкиПользователейИПрав");
КонецПроцедуры

&НаКлиенте
Процедура ИнформацияОСоздателе(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура КонсольЗапросов(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ИнформацияОБазе(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура СклонениеСлов(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура ИсправлениеКонтактнойИнформации(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура РегистрацияВнешнихКомпонент(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура СписокБаз1С(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура Дополнение_сс_РегистрацияСтатусов(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

&НаКлиенте
Процедура УправлениеБезопаснымХранилищем(Команда)
	ОткрытьФормуОбработки(Команда);
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

////////////////////////////////////////////////////////////////////////////////
// Клиент

&НаКлиенте
Процедура Подключаемый_ПриИзмененииРеквизита(Элемент, ОбновлятьИнтерфейс = Истина)
	
	МассивИменКонстант = ПриИзмененииРеквизитаСервер(Элемент.Имя);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Если ОбновлятьИнтерфейс Тогда
		ОбновитьИнтерфейс = Истина;
		ПодключитьОбработчикОжидания("ОбновитьИнтерфейсПрограммы", 2, Истина);
	КонецЕсли;
	
	Для Каждого КонстантаИмя Из МассивИменКонстант Цикл
		Если КонстантаИмя <> "" Тогда
			Оповестить("Запись_НаборКонстант", Новый Структура, КонстантаИмя);
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИнтерфейсПрограммы()
	
	Если ОбновитьИнтерфейс = Истина Тогда
		ОбновитьИнтерфейс = Ложь;
		ОбщегоНазначенияКлиент.ОбновитьИнтерфейсПрограммы();
	КонецЕсли;
	
КонецПроцедуры

////////////////////////////////////////////////////////////////////////////////
// Вызов сервера

&НаСервере
Функция ПриИзмененииРеквизитаСервер(ИмяЭлемента)
	
	МассивИменКонстант = Новый Массив;
	
	РеквизитПутьКДанным = Элементы[ИмяЭлемента].ПутьКДанным;
	
	НачатьТранзакцию();
	Попытка
		
		КонстантаИмя = СохранитьЗначениеРеквизита(РеквизитПутьКДанным);
		МассивИменКонстант.Добавить(КонстантаИмя);
		ЗафиксироватьТранзакцию();
	Исключение
		ОтменитьТранзакцию();
		ВызватьИсключение;
	КонецПопытки;
	
	//УстановитьДоступность(РеквизитПутьКДанным);
	
	ОбновитьПовторноИспользуемыеЗначения();
	
	Возврат МассивИменКонстант;
	
КонецФункции

////////////////////////////////////////////////////////////////////////////////
// Сервер

&НаСервере
Функция СохранитьЗначениеРеквизита(РеквизитПутьКДанным)
	
	// Сохранение значений реквизитов, не связанных с константами напрямую (в отношении один-к-одному).
	Если РеквизитПутьКДанным = "" Тогда
		Возврат "";
	КонецЕсли;
	
	// Определение имени константы.
	КонстантаИмя = "";
	Если НРег(Лев(РеквизитПутьКДанным, 14)) = НРег("НаборКонстант.") Тогда
		// Если путь к данным реквизита указан через "НаборКонстант".
		КонстантаИмя = Сред(РеквизитПутьКДанным, 15);
	Иначе
		// Определение имени и запись значения реквизита в соответствующей константе из "НаборКонстант".
		// Используется для тех реквизитов формы, которые связаны с константами напрямую (в отношении один-к-одному).
	КонецЕсли;
	
	// Сохранения значения константы.
	Если КонстантаИмя <> "" Тогда
		КонстантаМенеджер = Константы[КонстантаИмя];
		КонстантаЗначение = НаборКонстант[КонстантаИмя];
		ТекущееЗначение  = КонстантаМенеджер.Получить();
		
		Если ТекущееЗначение <> КонстантаЗначение Тогда
			Попытка
				КонстантаМенеджер.Установить(КонстантаЗначение);
			Исключение
				НаборКонстант[КонстантаИмя] = ТекущееЗначение;
				ВызватьИсключение;
			КонецПопытки;
		КонецЕсли;
	КонецЕсли;
	
	Возврат КонстантаИмя;
	
КонецФункции

#КонецОбласти
