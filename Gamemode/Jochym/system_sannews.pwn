AntiDeAMX();
CMD:news(playerid,cmdtext[])
{
	//printf("U�yta komenda news");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!ZarzadzanieNews(playerid))
	{
		GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby skokorzysta� z tej komendy musisz wej�� na s�u�be grupy.", "Zamknij", "");
		return 0;
	}
	new uidg = DaneGracza[playerid][gSluzba];
	strdel(tekst_global, 0, 2048);
	if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_SANNEWS)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby skokorzysta� z tej komendy musisz wej�� na s�u�be grupy.", "Zamknij", "");
		return 0;
	}
	if(sscanf(cmdtext, "s[256]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby napisa� newsa wpisz: /news [tre��]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Wpisana wiadomo�� jest nie poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(GetPVarInt(playerid, "NadalReklame") > gettime()+CZAS_LETNI)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, GUIOPIS "Informacja", "Odczekaj minut� od poprzedniej reklamy, kt�r� nada�e�!", "Zamknij", "");
		return 0;
	}
	if(blad != 1)
	{
	    new query[1024];
		format(query, sizeof(query), "UPDATE `jochym_serwer` SET `spiker` = '%s', `news` = '%s', `czas` = '%d' WHERE `x` = '%d'"
		, ZmianaNicku(playerid), tekst_global, 5, 1);
		mysql_check();
		mysql_query(query);
		format(tekst_global, sizeof(tekst_global), "~w~%s ~>~ %s ~>~~w~ %s",GrupaInfo[uidg][gNazwa], ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SNINFO = 60*5;
		SetPVarInt(playerid, "NadalReklame", gettime()+CZAS_LETNI+60);
	}
	return 1;
	
}
CMD:wywiad(playerid,cmdtext[])
{
	//printf("U�yta komenda wywiad");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(DaneGracza[playerid][gWywiad] == 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "s[512]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby napisa� na antenie wpisz: /wywiad [tre��]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	if(ComparisonString(tekst_global, "zakoncz"))
	{
		if(!ZarzadzanieLive(playerid))
		{
			GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
			return 0;
		}
		dShowPlayerDialog(DaneGracza[playerid][gWywiad], DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Reporter zako�czy� z tob� wywiad!", "Zamknij", "");
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Zako�czy�e� wywiad.", "Zamknij", "");
		DaneGracza[DaneGracza[playerid][gWywiad]][gWywiad] = 0;
		DaneGracza[playerid][gWywiad] = 0;
		return 0;
	}
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Wpisana wiadomo�� jest nie poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(blad != 1)
	{
		format(tekst_global, sizeof(tekst_global), "~w~~r~(Wywiad)~w~ ~>~ %s~w~ ~>~ %s", ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SNINFO = 60*2;
	}
	return 1;
	
}
CMD:reklama(playerid,cmdtext[])
{
	//printf("U�yta komenda reklama");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!ZarzadzanieReklama(playerid))
	{
		GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby skokorzysta� z tej komendy musisz wej�� na s�u�be grupy.", "Zamknij", "");
		return 0;
	}
	new uidg = DaneGracza[playerid][gSluzba];
	if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_SANNEWS)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby skokorzysta� z tej komendy musisz wej�� na s�u�be grupy.", "Zamknij", "");
		return 0;
	}
	new czas;
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "ds[512]", czas, tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby napisa� newsa wpisz: /reklama [ilo�� minut] [tre��]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Wpisana wiadomo�� jest nie poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(GetPVarInt(playerid, "NadalReklame") > gettime()+CZAS_LETNI)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, GUIOPIS "Informacja", "Odczekaj minut� od poprzedniej reklamy, kt�r� nada�e�!", "Zamknij", "");
		return 0;
	}
	if(blad != 1)
	{
		format(tekst_global, sizeof(tekst_global), "~w~%s ~>~ %s ~>~~w~ %s",GrupaInfo[uidg][gNazwa], ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SetPVarInt(playerid, "NadalReklame", gettime()+CZAS_LETNI+60);
		SNINFO = czas*60;
	}
	return 1;
}
CMD:live(playerid,cmdtext[])
{
	//printf("U�yta komenda live");
	if(zalogowany[playerid] == false)
    {
        return 0;
    }
	if(!ZarzadzanieLive(playerid))
	{
		GameTextForPlayer(playerid, "~r~Brak uprawnien.", 3000, 5);
		return 0;
	}
	if(DaneGracza[playerid][gBW] != 0)
	{
		return 0;
	}
	if(DaneGracza[playerid][gSluzba] == 0)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby skokorzysta� z tej komendy musisz wej�� na s�u�be grupy.", "Zamknij", "");
		return 0;
	}
	new uidg = DaneGracza[playerid][gSluzba];
	if(GrupaInfo[uidg][gTyp] != DZIALALNOSC_SANNEWS)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby skokorzysta� z tej komendy musisz wej�� na s�u�be grupy.", "Zamknij", "");
		return 0;
	}
	strdel(tekst_global, 0, 2048);
	if(sscanf(cmdtext, "s[512]", tekst_global))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby napisa� newsa wpisz: /live [tre��]", "Zamknij", "");
		return 1;
	}
	UsunPLZnaki(tekst_global);
	new ilosc_znakow = strlen(tekst_global), blad = 0;
	for(new i = 0; i < ilosc_znakow; i++)
	{
		if(tekst_global[i] == '~')
		{
			new nowy = i+2, stary = i-2;
			if(tekst_global[nowy] == '~' || tekst_global[stary] == '~')
			{
				blad = 0;
			}
			else
			{
				dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Wpisana wiadomo�� jest nie poprawna!", "Zamknij", "");
				blad = 1;
				break;
			}
		}
	}
	if(GetPVarInt(playerid, "NadalReklame") > gettime()+CZAS_LETNI)
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, GUIOPIS "Informacja", "Odczekaj minut� od poprzedniej reklamy, kt�r� nada�e�!", "Zamknij", "");
		return 0;
	}
	if(blad != 1)
	{
		format(tekst_global, sizeof(tekst_global), "~w~%s ~>~ %s ~>~~w~ %s",GrupaInfo[uidg][gNazwa], ZmianaNicku(playerid), tekst_global);
		TextDrawShowForAll(LosSantosFM);
		TextDrawSetString(LosSantosFM, tekst_global);
		SNINFO = 60*2;
		SetPVarInt(playerid, "NadalReklame", gettime()+CZAS_LETNI+60);
	}
	return 1;
}
