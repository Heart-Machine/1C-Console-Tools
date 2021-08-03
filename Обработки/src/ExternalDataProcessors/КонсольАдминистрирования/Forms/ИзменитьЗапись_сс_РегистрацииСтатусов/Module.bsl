
&НаСервере
Процедура ПриЗаписиНаСервере(Отказ, ТекущийОбъект, ПараметрыЗаписи)
	
	Если ЗначениеЗаполнено(Параметры.Ключ) Тогда
		возврат;
	КонецЕсли;
																   
	Док=ТекущийОбъект.Документ;															   	
	МассивДокументов= новый массив;
	МассивДокументов.Добавить(Док);
	Если ТекущийОбъект.Вид = Перечисления.сс_ВидыРегистрацииСтатусов.УПД Тогда
		Если ТекущийОбъект.Статус=Перечисления.сс_Статус.ВернулиОК Тогда
			Если ТипЗнч(Док) = Тип("ДокументСсылка.РеализацияТоваровУслуг") тогда
				сс_МодульСервер.УстановитьСтатусыДокументов(МассивДокументов,Перечисления.СтатусыДокументовРеализации.Подписан);
			ИначеЕсли ТипЗнч(Док) = Тип("ДокументСсылка.ПоступлениеТоваровУслуг") тогда
				сс_МодульСервер.УстановитьСтатусыДокументов(МассивДокументов,Перечисления.СтатусыДокументовПоступления.ОригиналПолучен);
			КонецЕсли;
		Иначе	
			Если ТипЗнч(Док) = Тип("ДокументСсылка.РеализацияТоваровУслуг") тогда
				сс_МодульСервер.УстановитьСтатусыДокументов(МассивДокументов,Перечисления.СтатусыДокументовРеализации.НеПодписан) ;
			ИначеЕсли ТипЗнч(Док) = Тип("ДокументСсылка.ПоступлениеТоваровУслуг") тогда
				сс_МодульСервер.УстановитьСтатусыДокументов(МассивДокументов,Перечисления.СтатусыДокументовПоступления.ОригиналНеПолучен);
			КонецЕсли;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеЗаписи(ПараметрыЗаписи)
	
	ПараметрыОповещения = Новый Массив;
	ПараметрыОповещения.Добавить(Запись.Документ);
	Оповестить("ИзмененСтатусДокументов", ПараметрыОповещения); // Оповещение открытых форм документов
	
КонецПроцедуры
