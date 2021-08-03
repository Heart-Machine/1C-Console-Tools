
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	//V82COMConnector = Новый COMОбъект("V83.COMConnector");
КонецПроцедуры

&НаКлиенте
Процедура ПутьККомпонентеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	Диалог.Фильтр = "Динамическая библиотека (*.dll)|*.dll";
	Если Диалог.Выбрать() Тогда
        ПутьККомпоненте = Диалог.ПолноеИмяФайла;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПутьККомпонентеОткрытие(Элемент, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Если ПустаяСтрока(ПутьККомпоненте) Тогда
	    Возврат;	
	КонецЕсли;
	
	Файл = Новый Файл(ПутьККомпоненте);
	Если Файл.Существует() Тогда
		СисИнфо = Новый СистемнаяИнформация;
		Если СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86 Или СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86_64 Тогда
			Shell = Новый COMОбъект("WScript.Shell");
			WindowsDir = Shell.ExpandEnvironmentStrings("%WINDIR%");    
			ЗапуститьПриложение(WindowsDir + "\explorer.exe /select,""" + Файл.ПолноеИмя + """");	
		Иначе
			ЗапуститьПриложение(Файл.Путь);
		КонецЕсли;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПоискБиблиотекКОМ(Команда)
	
	Если ВыборКлиентСервер Тогда
		ПоискБиблиотекКОМНаСервере();		
	Иначе
		СписокПлатформ.Очистить();
		
		Путь64 = "C:\Program Files\1cv8";
		Папка = Новый Файл(Путь64);
		Если Папка.Существует() Тогда
			ПапкиПлатформ = НайтиФайлы(Путь64, "8.*");
			Для каждого ПапкаПлатформы Из ПапкиПлатформ Цикл
				ПутьDLL = ПапкаПлатформы.ПолноеИмя + "\bin\comcntr.dll";
				ФайлDLL = Новый Файл(ПутьDLL);
				Если ФайлDLL.Существует() Тогда
					СписокПлатформ.Добавить(ПутьDLL, ПапкаПлатформы.Имя + " (x64)");
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
		
		Путь32 = "C:\Program Files (x86)\1cv8";
		Папка = Новый Файл(Путь32);
		Если Папка.Существует() Тогда
			ПапкиПлатформ = НайтиФайлы(Путь32, "8.*");
			Для каждого ПапкаПлатформы Из ПапкиПлатформ Цикл
				ПутьDLL = ПапкаПлатформы.ПолноеИмя + "\bin\comcntr.dll";
				ФайлDLL = Новый Файл(ПутьDLL);
				Если ФайлDLL.Существует() Тогда
					СписокПлатформ.Добавить(ПутьDLL, ПапкаПлатформы.Имя + " (x32)");
				КонецЕсли;
			КонецЦикла;
		КонецЕсли;
	КонецЕсли;

	Оповещение = Новый ОписаниеОповещения("ПоискБиблиотекКОМЗавершение", ЭтотОбъект);
	
	СисИнфо = Новый СистемнаяИнформация;
	ПутьКПлатформе = ?(СисИнфо.ТипПлатформы = ТипПлатформы.Windows_x86_64, Путь64, Путь32);
	ЭлементТекущейПлатформы = СписокПлатформ.НайтиПоЗначению(ПутьКПлатформе + "\" + СисИнфо.ВерсияПриложения + "\bin\comcntr.dll");
	Если ЭлементТекущейПлатформы = Неопределено Тогда
	    СписокПлатформ.ПоказатьВыборЭлемента(Оповещение, "Выберите компоненту платформы");
	Иначе
		НовыйШрифт = Новый Шрифт(,,,Истина,Истина);
		ЭлементТекущейПлатформы.Представление = Новый ФорматированнаяСтрока(ЭлементТекущейПлатформы.Представление, НовыйШрифт);
	    СписокПлатформ.ПоказатьВыборЭлемента(Оповещение, "Выберите компоненту платформы", ЭлементТекущейПлатформы);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ПоискБиблиотекКОМНаСервере()
	СписокПлатформ.Очистить();
	
	Путь64 = "C:\Program Files\1cv8";
	Папка = Новый Файл(Путь64);
	Если Папка.Существует() Тогда
		ПапкиПлатформ = НайтиФайлы(Путь64, "8.*");
		Для каждого ПапкаПлатформы Из ПапкиПлатформ Цикл
			ПутьDLL = ПапкаПлатформы.ПолноеИмя + "\bin\comcntr.dll";
			ФайлDLL = Новый Файл(ПутьDLL);
			Если ФайлDLL.Существует() Тогда
			    СписокПлатформ.Добавить(ПутьDLL, ПапкаПлатформы.Имя + " (x64)");
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;
	
	Путь32 = "C:\Program Files (x86)\1cv8";
	Папка = Новый Файл(Путь32);
	Если Папка.Существует() Тогда
		ПапкиПлатформ = НайтиФайлы(Путь32, "8.*");
		Для каждого ПапкаПлатформы Из ПапкиПлатформ Цикл
			ПутьDLL = ПапкаПлатформы.ПолноеИмя + "\bin\comcntr.dll";
			ФайлDLL = Новый Файл(ПутьDLL);
			Если ФайлDLL.Существует() Тогда
			    СписокПлатформ.Добавить(ПутьDLL, ПапкаПлатформы.Имя + " (x32)");
			КонецЕсли;
		КонецЦикла;
	КонецЕсли;

	
КонецПроцедуры

&НаКлиенте
Процедура ПоискБиблиотекКОМЗавершение(Результат, ДопПараметры) Экспорт

	Если Результат = Неопределено Тогда		
		Возврат;
	КонецЕсли;
	
	ПутьККомпоненте = Результат.Значение;

КонецПроцедуры // ПоискБиблиотекКОМЗавершение()

&НаКлиенте
Процедура УстановитьРегистрацию(Команда)
	
	Если ВыборКлиентСервер Тогда
		УстановитьРегистрациюНаСервере();
		Возврат;
	КонецЕсли;
	
	ВременныйФайл = СоздатьВременныйФайлСТекстом("regsvr32 """ + ПутьККомпоненте + """");	
	Shell = Новый COMОбъект("Shell.Application");
	Shell.ShellExecute(ВременныйФайл, "", "", "runas", 1);
	
	КомандаWindows = "Timeout /T " + Формат(1, "ЧГ=0") + " /NoBreak";	
	WshShell = Новый COMОбъект("WScript.Shell"); 
	WshShell.Run(КомандаWindows, 0, -1);
	
	УдалитьФайлы(ВременныйФайл);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьРегистрациюНаСервере()
	ВременныйФайл = СоздатьВременныйФайлСТекстомНаСервере("regsvr32 """ + ПутьККомпоненте + """");	
	Shell = Новый COMОбъект("Shell.Application");
	Shell.ShellExecute(ВременныйФайл, "", "", "runas", 1);
	
	КомандаWindows = "Timeout /T " + Формат(1, "ЧГ=0") + " /NoBreak";	
	WshShell = Новый COMОбъект("WScript.Shell"); 
	WshShell.Run(КомандаWindows, 0, -1);
	
	УдалитьФайлы(ВременныйФайл);
КонецПроцедуры

&НаКлиенте
Процедура СнятьРегистрацию(Команда)
	
	Если ВыборКлиентСервер Тогда
		СнятьРегистрациюНаСервере();
		Возврат;
	КонецЕсли;
	
	ВременныйФайл = СоздатьВременныйФайлСТекстом("regsvr32 """ + ПутьККомпоненте + """ /u");	
	Shell = Новый COMОбъект("Shell.Application");
	Shell.ShellExecute(ВременныйФайл, "", "", "runas", 1);
	
	КомандаWindows = "Timeout /T " + Формат(1, "ЧГ=0") + " /NoBreak";	
	WshShell = Новый COMОбъект("WScript.Shell"); 
	WshShell.Run(КомандаWindows, 0, -1);
	
	УдалитьФайлы(ВременныйФайл);
	
КонецПроцедуры

&НаСервере
Процедура СнятьРегистрациюНаСервере()
	
	ВременныйФайл = СоздатьВременныйФайлСТекстомНаСервере("regsvr32 """ + ПутьККомпоненте + """ /u");	
	Shell = Новый COMОбъект("Shell.Application");
	Shell.ShellExecute(ВременныйФайл, "", "", "runas", 1);
	
	КомандаWindows = "Timeout /T " + Формат(1, "ЧГ=0") + " /NoBreak";	
	WshShell = Новый COMОбъект("WScript.Shell"); 
	WshShell.Run(КомандаWindows, 0, -1);
	
	УдалитьФайлы(ВременныйФайл);
	
КонецПроцедуры

&НаКлиенте
Функция СоздатьВременныйФайлСТекстом(Текст)
	
	Если ВыборКлиентСервер Тогда
	    Возврат СоздатьВременныйФайлСТекстомНаСервере(Текст);
	КонецЕсли;
	
	ВременныйФайл = ПолучитьИмяВременногоФайла(".bat");
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.УстановитьТекст(Текст);
	ТекстовыйДокумент.Записать(ВременныйФайл, "windows-1251");
	
	Возврат ВременныйФайл;
	
КонецФункции // СоздатьВременныйФайлСТекстом()

&НаСервере
Функция СоздатьВременныйФайлСТекстомНаСервере(Текст)
	
	ВременныйФайл = ПолучитьИмяВременногоФайла(".bat");
	ТекстовыйДокумент = Новый ТекстовыйДокумент;
	ТекстовыйДокумент.УстановитьТекст(Текст);
	ТекстовыйДокумент.Записать(ВременныйФайл, "windows-1251");
	
	Возврат ВременныйФайл;
	
КонецФункции // СоздатьВременныйФайлСТекстом()

&НаКлиенте
Процедура КомпонентаСклонения(Команда)
	ЗапуститьПриложение("https://its.1c.ru/db/metod8dev/content/2967/hdoc");
КонецПроцедуры

&НаКлиенте
Процедура ВыборКлиентСерверПриИзменении(Элемент)
	ВыбранСервер = ВыборКлиентСервер = 1;
КонецПроцедуры





