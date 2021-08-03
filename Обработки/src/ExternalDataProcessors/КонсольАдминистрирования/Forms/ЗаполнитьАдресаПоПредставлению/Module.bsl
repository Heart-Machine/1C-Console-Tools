
&НаСервере
Функция ИсправитьАдресаНаСервере(НомерСтроки, Сч)
	    
	Строка = ТаблицаАдресов.НайтиПоИдентификатору(НомерСтроки);
	ОбъектСпр = Строка.ОбъектСсылка.ПолучитьОбъект();
	
	Если Строка.ДанныеИзменены Тогда 
		Возврат Истина;
	ИначеЕсли ПустаяСтрока(Строка.Представление) Тогда 
		Возврат Ложь;
	КонецЕсли;
	
	Если ПустаяСтрока(Строка.Тип) Или ПустаяСтрока(Строка.Вид) Тогда
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("Тип", Строка.Тип);
		СтруктураОтбора.Вставить("Вид", Строка.Вид);
		СтруктураОтбора.Вставить("Представление", Строка.Представление);
		НайденныеСтроки = ОбъектСпр.КонтактнаяИнформация.НайтиСтроки(СтруктураОтбора);
		
		Если НайденныеСтроки.Количество() > 0 Тогда
			НайденнаяСтрока = НайденныеСтроки[0];
			ОбъектСпр.КонтактнаяИнформация.Удалить(НайденнаяСтрока.НомерСтроки - 1);
			ОбъектСпр.Записать();
		КонецЕсли;
		Сообщить("Данные были удалены. Изменено " + Сч + " из " + ТаблицаАдресов.Количество());
		Возврат Истина;
	КонецЕсли;
	
	АдресJSON = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияПоПредставлению(Строка.Представление, Строка.Вид);
	Если Строка.Значение <> АдресJSON Тогда 
		Строка.Значение = АдресJSON;
		АдресXML = УправлениеКонтактнойИнформацией.КонтактнаяИнформацияВXML(АдресJSON, Строка.Представление, Строка.Вид);
		Если Строка.ЗначенияПолей <> АдресXML Тогда
			Строка.ЗначенияПолей = АдресXML
		КонецЕсли;
		
		//ОбъектСпр = Справочники.ФизическиеЛица.СоздатьЭлемент();
		
		СтруктураОтбора = Новый Структура;
		СтруктураОтбора.Вставить("Тип", Строка.Тип);
		СтруктураОтбора.Вставить("Вид", Строка.Вид);
		СтруктураОтбора.Вставить("Представление", Строка.Представление);
		НайденныеСтроки = ОбъектСпр.КонтактнаяИнформация.НайтиСтроки(СтруктураОтбора);
		
		Если НайденныеСтроки.Количество() > 0 Тогда
			НайденнаяСтрока = НайденныеСтроки[0];
			НайденнаяСтрока.Значение = Строка.Значение;
			НайденнаяСтрока.ЗначенияПолей = Строка.ЗначенияПолей;
			
			ОбъектСпр.Записать();
		КонецЕсли;
		
		Сообщить("Данные были изменены. Изменено " + Сч + " из " + ТаблицаАдресов.Количество());
		Возврат Истина;
	Иначе
		Возврат Ложь;
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ИсправитьАдреса(Команда)
	
	Сч = 0;
	
	Для каждого Строка Из ТаблицаАдресов Цикл
		
		Если Не ПустаяСтрока(Строка.Представление) Тогда
			Сч = Сч + 1;
			Строка.ДанныеИзменены = ИсправитьАдресаНаСервере(Строка.ПолучитьИдентификатор(), Сч);
			//Возврат;
		КонецЕсли;	
		
		ОбработкаПрерыванияПользователя();
		
	КонецЦикла;
	
	ОбновитьТаблицуАдресов();

КонецПроцедуры

&НаСервере
Процедура ОбновитьТаблицуАдресов()
	
	ТаблицаАдресов.Очистить();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ФизическиеЛицаКонтактнаяИнформация.Тип КАК Тип,
	|	ФизическиеЛицаКонтактнаяИнформация.Вид КАК Вид,
	|	ФизическиеЛицаКонтактнаяИнформация.Представление КАК Представление,
	|	ФизическиеЛицаКонтактнаяИнформация.ЗначенияПолей КАК ЗначенияПолей,
	|	ФизическиеЛицаКонтактнаяИнформация.Значение КАК Значение,
	|	ФизическиеЛицаКонтактнаяИнформация.Ссылка КАК ОбъектСсылка
	|ИЗ
	|	Справочник.ФизическиеЛица.КонтактнаяИнформация КАК ФизическиеЛицаКонтактнаяИнформация";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выгрузить();
	ТаблицаАдресов.Загрузить(Выборка);
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КонтактныеЛицаКонтактнаяИнформация.Тип КАК Тип,
	|	КонтактныеЛицаКонтактнаяИнформация.Вид КАК Вид,
	|	КонтактныеЛицаКонтактнаяИнформация.Представление КАК Представление,
	|	КонтактныеЛицаКонтактнаяИнформация.ЗначенияПолей КАК ЗначенияПолей,
	|	КонтактныеЛицаКонтактнаяИнформация.Значение КАК Значение,
	|	КонтактныеЛицаКонтактнаяИнформация.Ссылка КАК ОбъектСсылка
	|ИЗ
	|	Справочник.КонтактныеЛица.КонтактнаяИнформация КАК КонтактныеЛицаКонтактнаяИнформация";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выгрузить();
	Для каждого Строка Из Выборка Цикл
		НоваяСтрока = ТаблицаАдресов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);	
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	КонтрагентыКонтактнаяИнформация.Тип КАК Тип,
	|	КонтрагентыКонтактнаяИнформация.Вид КАК Вид,
	|	КонтрагентыКонтактнаяИнформация.Представление КАК Представление,
	|	КонтрагентыКонтактнаяИнформация.ЗначенияПолей КАК ЗначенияПолей,
	|	КонтрагентыКонтактнаяИнформация.Значение КАК Значение,
	|	КонтрагентыКонтактнаяИнформация.Ссылка КАК ОбъектСсылка
	|ИЗ
	|	Справочник.Контрагенты.КонтактнаяИнформация КАК КонтрагентыКонтактнаяИнформация";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выгрузить();
	Для каждого Строка Из Выборка Цикл
		НоваяСтрока = ТаблицаАдресов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);	
	КонецЦикла;
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	ОрганизацииКонтактнаяИнформация.Тип КАК Тип,
	|	ОрганизацииКонтактнаяИнформация.Вид КАК Вид,
	|	ОрганизацииКонтактнаяИнформация.Представление КАК Представление,
	|	ОрганизацииКонтактнаяИнформация.ЗначенияПолей КАК ЗначенияПолей,
	|	ОрганизацииКонтактнаяИнформация.Значение КАК Значение,
	|	ОрганизацииКонтактнаяИнформация.Ссылка КАК ОбъектСсылка
	|ИЗ
	|	Справочник.Организации.КонтактнаяИнформация КАК ОрганизацииКонтактнаяИнформация";
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выгрузить();
	Для каждого Строка Из Выборка Цикл
		НоваяСтрока = ТаблицаАдресов.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);	
	КонецЦикла;
	
	ЭтотОбъект.Модифицированность = Ложь;
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьСписок(Команда)
	ОбновитьТаблицуАдресов();
КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ОбновитьТаблицуАдресов();
КонецПроцедуры

&НаСервере
Функция УдалитьБезПредставленияНаСервере(НомерСтроки, Сч)
	
	Строка = ТаблицаАдресов.НайтиПоИдентификатору(НомерСтроки);
	ОбъектСпр = Строка.ОбъектСсылка.ПолучитьОбъект();
	
	Если Строка.ДанныеИзменены Тогда 
		Возврат Истина;
	КонецЕсли;
	
	СтруктураОтбора = Новый Структура;
	СтруктураОтбора.Вставить("Тип", Строка.Тип);
	СтруктураОтбора.Вставить("Вид", Строка.Вид);
	СтруктураОтбора.Вставить("Представление", Строка.Представление);
	СтруктураОтбора.Вставить("ЗначенияПолей", Строка.ЗначенияПолей);
	СтруктураОтбора.Вставить("Значение", Строка.Значение);
	НайденныеСтроки = ОбъектСпр.КонтактнаяИнформация.НайтиСтроки(СтруктураОтбора);
	
	Если НайденныеСтроки.Количество() > 0 Тогда
		НайденнаяСтрока = НайденныеСтроки[0];
		ОбъектСпр.КонтактнаяИнформация.Удалить(НайденнаяСтрока.НомерСтроки - 1);
		ОбъектСпр.Записать();
	КонецЕсли;
	
	Сообщить("Данные были удалены. Изменено " + Сч + " из " + ТаблицаАдресов.Количество());
	
	Возврат Истина;
	
КонецФункции

&НаКлиенте
Процедура УдалитьБезПредставления(Команда)
	
	Сч = 0;
	
	Для каждого Строка Из ТаблицаАдресов Цикл
		
		Если ПустаяСтрока(Строка.Представление) Тогда
			Сч = Сч + 1;
			Строка.ДанныеИзменены = УдалитьБезПредставленияНаСервере(Строка.ПолучитьИдентификатор(), Сч);
			//Возврат;
		КонецЕсли;	
		
		ОбработкаПрерыванияПользователя();
		
	КонецЦикла;
		
	ОбновитьТаблицуАдресов();
	
КонецПроцедуры
