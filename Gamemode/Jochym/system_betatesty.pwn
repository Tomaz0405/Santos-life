/*CMD:kasa(playerid, cmdtext[])
{
    if(zalogowany[playerid] == false)
    {
        return 0;
    }
	new ilosc;
	if(sscanf(cmdtext, "d", ilosc))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby nada� sobie pieni�dze wpisz: /kasa [ilo��]", "Zamknij", "");
		return 1;
	}
	if(ilosc > 0 && ilosc < 9999999)
	{
    	Dodajkase(playerid, ilosc);
    	new str[126];
    	format(str, sizeof(str), "doda� sobie troch� pieni�dzy.");
		cmd_fasdasfdfive(playerid,str);
	}
	else
	{
	    dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Mo�esz da� sobie wi�cej ni� 0$ oraz mniej ni� 9999999$", "Zamknij", "");
		return 1;
	}
	return 1;
}

CMD:pozwolenie(playerid, cmdtext[])
{
	DaneGracza[playerid][gPozwolenie] = 1;
	ZapiszGracza(playerid);
	dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� TIP", "Przydzieli�e� sobie pozwolenie na stworzenie dzia�ano�ci gospodarczej u Urz�dnika(Aktora)", "Zamknij", "");
	return 1;
}

CMD:hp(playerid, params[])
{
	new ilosc;
	if(sscanf(params, "d", ilosc))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "Aby nada� sobie HP wpisz: /hp [ilo��]", "Zamknij", "");
		return 1;
	}
    if(ilosc <= 100)
	{
		UstawHP(playerid, ilosc);
		SetPlayerDrunkLevel(playerid, 0);
		PlayerPlaySound(playerid, 1190, 0.0, 0.0, 0.0);
		new tekst[126];
		format(tekst, sizeof(tekst), "Nada�es sobie pe�ne HP.");
		SendClientMessage(playerid, KOLOR, tekst);
	}
	return 1;
}
CMD:unbw(playerid, cmdtext[])
{
	new tekst[126];
	format(tekst, sizeof(tekst), "Zdj��e� sobie BW.");
	SendClientMessage(playerid, KOLOR, tekst);
	TextDrawHideForPlayer(playerid, TextNaDrzwi[playerid]);
	SetCameraBehindPlayer(playerid);
	UstawHP(playerid, 100);
	DaneGracza[playerid][gBW] = 0;
	ZapiszGracza(playerid);
	RefreshNick(playerid);
	Frezuj(playerid, 1);
	new uid = BWwAucie[playerid];
	PojazdInfo[uid][pTempomat] = 0;
	ZapiszPojazd(uid, 1);
	ZapiszPojazd(uid, 2);
	BWwAucie[playerid] = 0;
	new przelew[124];
	format(przelew, sizeof(przelew), "[UNBW] %s (ID:%d) zdj�� sobie BW",ZmianaNicku(playerid), playerid);
	KomunikatAdmin(1, przelew);
	return 1;
}

CMD:obiekt(playerid, cmdtext[])
{
    new wynik;
	if(sscanf(cmdtext, "d", wynik))
	{
		dShowPlayerDialog(playerid, DIALOG_INFO, DIALOG_STYLE_MSGBOX, "� Informacja:", "By doda� sobie obiekty wpisz: /obiekt [ilosc]", "Zamknij", "");
		return 1;
	}
	DaneGracza[playerid][gObiekty] += wynik;
	ZapiszGracza(playerid);
	ZapiszGraczaGlobal(playerid, 10);
	new tekst[126];
	format(tekst, sizeof(tekst), "Doda�e� sobie obiekty.");
	SendClientMessage(playerid, KOLOR, tekst);
	return 1;
}*/
