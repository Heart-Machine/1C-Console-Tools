
&НаСервере
Процедура ЗаполнитьДокументыНаСервере()
	
	Реализация.Очистить();
	Для каждого СтрокаСписка Из Элементы.Список.ВыделенныеСтроки Цикл
		Если Не СтрокаСписка.ПометкаУдаления Тогда
			Строка = Реализация.Добавить();
			Строка.Документ = СтрокаСписка.Ссылка;
			Строка.Дата = СтрокаСписка.Дата;
			Строка.Номер = СтрокаСписка.Номер;
			Строка.Сумма = СтрокаСписка.СуммаДокумента;
			Строка.Контрагент = СтрокаСписка.Контрагент;
			Строка.Комментарий = СтрокаСписка.Комментарий;
			Строка.Организация = СтрокаСписка.Организация;
			Строка.ПеревозкаАвтотранспортом = СтрокаСписка.ПеревозкаАвтотранспортом;
		КонецЕсли;
	КонецЦикла;
	Реализация.Сортировать("Дата Возв");
	Элементы.Реализация.Обновить();
	Элементы.Страницы.ТекущаяСтраница = Элементы.Страница2;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДокументы(Команда)
	ЗаполнитьДокументыНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура ОтборОрганизацияПриИзменении(Элемент)
	ОтборОрганизацияИспользование = ЗначениеЗаполнено(ОтборОрганизация);
	ОтборыСписковКлиентСервер.УстановитьБыстрыйОтбор(ЭтотОбъект, "Организация");
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонтрагентПриИзменении(Элемент)
	ОтборКонтрагентИспользование = ЗначениеЗаполнено(ОтборКонтрагент);
	ОтборыСписковКлиентСервер.УстановитьБыстрыйОтбор(ЭтотОбъект, "Контрагент");
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьДокументыНаСервере(Результат, Параметры) Экспорт
	 Если Результат = КодВозвратаДиалога.Да Тогда
        ЗаписьДок();
    КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ЗаписьДок()
	
	Для каждого Строка Из Реализация Цикл
		Документ = Строка.Документ.ПолучитьОбъект();
		Если Документ.ПеревозкаАвтотранспортом <> Строка.ПеревозкаАвтотранспортом Тогда
			Документ.ПеревозкаАвтотранспортом = Строка.ПеревозкаАвтотранспортом;
			Документ.ОбменДанными.Загрузка = Истина;
			Попытка
				УстановитьПривилегированныйРежим(Истина);
				Документ.Записать(РежимЗаписиДокумента.Запись);	
				УстановитьПривилегированныйРежим(Ложь);
			Исключение
				Сообщить(Строка(Документ) + " не удалось записать!");
				Сообщить(ОписаниеОшибки());
			КонецПопытки;
		КонецЕсли;
	КонецЦикла;
	Сообщить("Запись документов завершена!");
	
КонецПроцедуры


&НаКлиенте
Процедура ЗаписатьДокументы(Команда)
	Оповещение = Новый ОписаниеОповещения("ЗаписатьДокументыНаСервере", ЭтотОбъект);	
 
    ПоказатьВопрос(Оповещение, "Документы будут записаны. Вы уверены?", РежимДиалогаВопрос.ДаНет, 0, КодВозвратаДиалога.Нет, "Оповещение");
		
КонецПроцедуры

&НаКлиенте
Процедура ОтборОрганизацияИспользованиеПриИзменении(Элемент)
	ОтборыСписковКлиентСервер.УстановитьБыстрыйОтбор(ЭтотОбъект, "Организация");
КонецПроцедуры

&НаКлиенте
Процедура ОтборКонтрагентИспользованиеПриИзменении(Элемент)
	ОтборыСписковКлиентСервер.УстановитьБыстрыйОтбор(ЭтотОбъект, "Контрагент");
КонецПроцедуры

&НаКлиенте
Процедура ПеревозкиИст(Команда)
	Для каждого Строка Из Реализация Цикл
		Строка.ПеревозкаАвтотранспортом = Истина;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПеревозкиИнверсия(Команда)
	Для каждого Строка Из Реализация Цикл
		Строка.ПеревозкаАвтотранспортом = Не Строка.ПеревозкаАвтотранспортом;
	КонецЦикла;
КонецПроцедуры

&НаКлиенте
Процедура ПеревозкиЛожь(Команда)
	Для каждого Строка Из Реализация Цикл
		Строка.ПеревозкаАвтотранспортом = Ложь;
	КонецЦикла;
КонецПроцедуры
