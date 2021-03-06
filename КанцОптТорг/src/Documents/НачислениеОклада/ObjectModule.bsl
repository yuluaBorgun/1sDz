
Процедура ОбработкаПроведения(Отказ, Режим)
	
	// регистр НачисленияЗП
	Движения.НачисленияЗП.Записывать = Истина;
	Движение = Движения.НачисленияЗП.Добавить();
	Движение.Сторно = Ложь;
	Движение.ВидРасчета = ПланыВидовРасчета.Начисления.ОкладПоТарифу;
	Движение.ПериодДействияНачало = НачалоМесяца(Дата);
	Движение.ПериодДействияКонец = КонецМесяца(Дата);
	Движение.ПериодРегистрации = Дата;
	Движение.Сотрудник = Сотрудник;
	Движение.РасчетныеДанные = ДневнойТариф;
	
	Движения.Записать();
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	НачисленияЗПДанныеГрафика.РасчетныеДанные,
	|	НачисленияЗПДанныеГрафика.РабочийДеньФактическийПериодДействия КАК Факт
	|ИЗ
	|	РегистрРасчета.НачисленияЗП.ДанныеГрафика(Регистратор = &Ссылка) КАК НачисленияЗПДанныеГрафика";
	
	Запрос.УстановитьПараметр("Ссылка", Ссылка);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	ВыборкаДетальныеЗаписи = РезультатЗапроса.Выбрать();
	
	Если ВыборкаДетальныеЗаписи.Следующий()Тогда
		Результат = ВыборкаДетальныеЗаписи.РасчетныеДанные *ВыборкаДетальныеЗаписи.Факт;
		Движение.Резульат = Результат; 
	КонецЕсли;
	
	Движения.НачисленияЗП.Записать();
	Движения.ЗадолжностьПередСотрудниками.Записывать = Истина;
	Движение = Движения.ЗадолжностьПередСотрудниками.Добавить();
	Движение.ВидДвижения = ВидДвиженияНакопления.Приход;
	Движение.Период = Дата;
	Движение.Сотрудник = Сотрудник;
	Движение.Долг = Результат;

КонецПроцедуры    
