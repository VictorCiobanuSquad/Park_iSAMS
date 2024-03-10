report 50100 "import isams to database"
{
    ApplicationArea = All;
    Caption = 'import isams to database';
    UsageCategory = Tasks;
    ProcessingOnly = true;
    dataset
    {
        dataitem(iSAMS; iSAMS)
        {



            trigger OnPreDataItem()
            begin

                riSAMS.RESET;
                riSAMS.SETRANGE(riSAMS.Duplicado, TRUE);
                IF riSAMS.FINDFIRST THEN
                    ERROR(Text0002);

                rEduConf.GET;     //#001 SQD RTV 20210622
            end;

            trigger OnAfterGetRecord()
            begin

                IF NOT rStudents.GET(iSAMS."Nº Processo") THEN BEGIN


                    rStudents.INIT;
                    rStudents."No." := iSAMS."Nº Processo";
                    rStudents."SchoolID iSAMS" := iSAMS."School ID";
                    IF iSAMS.Name <> '' THEN BEGIN
                        rStudents.Name := iSAMS.Name;
                        rStudents.UpdateFullName;
                        rStudents.UpdateProfile;
                    END;

                    IF iSAMS."VAT Registration No." <> '' THEN
                        rStudents.VALIDATE(rStudents."VAT Registration No.", iSAMS."VAT Registration No.");
                    IF iSAMS."Birth Date" <> 0D THEN rStudents.VALIDATE(rStudents."Birth Date", iSAMS."Birth Date");
                    IF iSAMS.Sex <> 0 THEN rStudents.VALIDATE(rStudents.Sex, iSAMS.Sex);

                    //IT001 - Parque - 2018.02.22,sn
                    IF iSAMS.Address <> '' THEN BEGIN
                        IF STRLEN(iSAMS.Address) <= 50 THEN
                            rStudents.VALIDATE(rStudents.Address, iSAMS.Address)
                        ELSE BEGIN
                            CLEAR(moradaaux);
                            CLEAR(Aux);
                            CLEAR(moradaComp);
                            moradaaux := iSAMS.Address;
                            Flag := FALSE;

                            WHILE (STRPOS(moradaaux, ' ') <> 0) AND (Flag = FALSE) DO BEGIN
                                Aux := COPYSTR(moradaaux, 1, STRPOS(moradaaux, ' ') - 1);
                                IF moradaComp = '' THEN
                                    moradaComp := Aux
                                ELSE BEGIN
                                    IF STRLEN(moradaComp + ' ' + Aux) > 50 THEN
                                        Flag := TRUE
                                    ELSE
                                        moradaComp := moradaComp + ' ' + Aux;
                                END;
                                moradaaux := COPYSTR(moradaaux, STRPOS(moradaaux, ' ') + 1);
                            END;
                            rStudents.VALIDATE(rStudents.Address, moradaComp);
                            rStudents.VALIDATE(rStudents."Address 2", Aux + ' ' + moradaaux);
                        END;
                    END;
                    //IT001 - Parque - 2018.02.22,en


                    //IF iSAMS.Address <> '' THEN rStudents.VALIDATE(rStudents.Address, iSAMS.Address);
                    IF (iSAMS."Post Code" <> '') AND (iSAMS."Post Code" <> '-') THEN rStudents."Post Code" := iSAMS."Post Code";
                    IF iSAMS.Location <> '' THEN rStudents.Location := iSAMS.Location;
                    //IT001 - Parque - 2018.02.22,sn
                    IF iSAMS."NIB-IBAN" <> '' THEN BEGIN
                        IF COPYSTR(iSAMS."NIB-IBAN", 1, 2) = 'PT' THEN BEGIN
                            rStudents.VALIDATE(rStudents.IBAN, iSAMS."NIB-IBAN");
                            rStudents.VALIDATE(rStudents.NIB, COPYSTR(iSAMS."NIB-IBAN", 5));
                        END ELSE BEGIN
                            rStudents.VALIDATE(rStudents.IBAN, 'PT50' + iSAMS."NIB-IBAN");
                            rStudents.VALIDATE(rStudents.NIB, iSAMS."NIB-IBAN");
                        END;
                    END;
                    //IT001 - Parque - 2018.02.22,en
                    IF iSAMS."E-mail" <> '' THEN rStudents.VALIDATE(rStudents."E-mail", iSAMS."E-mail");

                    IF rEduConf.GET THEN;
                    rStudents."Payment Method Code" := rEduConf."Payment Method Code";
                    rStudents."Currency Code" := rEduConf."Currency Code";
                    rStudents."Payment Terms Code" := rEduConf."Payment Terms Code";
                    rStudents."Customer Disc. Group" := rEduConf."Customer Disc. Group";
                    rStudents."Allow Line Disc." := rEduConf."Allow Line Disc.";
                    rStudents."Customer Posting Group" := rEduConf."Customer Posting Group";
                    rStudents."Gen. Bus. Posting Group" := rEduConf."Gen. Bus. Posting Group";
                    rStudents."VAT Bus. Posting Group" := rEduConf."VAT Bus. Posting Group";
                    rStudents."Use Student Disc. Group" := rEduConf."Use Student Disc. Group";
                    rStudents.VALIDATE(rStudents."Nationality Code", cStudentsRegistration.GetCountry);
                    rStudents.VALIDATE(rStudents."Naturalness Code", cStudentsRegistration.GetCountry);
                    rStudents."Country/Region Code" := cStudentsRegistration.GetCountry;
                    rStudents."User Id" := USERID;
                    rStudents.Date := WORKDATE;
                    //rStudents.InsertUsersStudent;

                    //CHECK IF INSERT
                    if rStudents.Name <> '' then
                        rStudents_Aux.Reset;
                    if rStudents.Name <> '' then
                        rStudents_Aux.SetRange(Name, Name)
                    else
                        rStudents_Aux.SetRange(Name, '');
                    if rStudents."Last Name" <> '' then
                        rStudents_Aux.SetFilter("Last Name", rStudents."Last Name")
                    else
                        rStudents_Aux.SetRange("Last Name", '');

                    if rStudents."Last Name 2" <> '' then
                        rStudents_Aux.SetRange("Last Name 2", rStudents."Last Name 2")
                    else
                        rStudents_Aux.SetRange("Last Name 2", '');

                    rStudents_Aux.SetFilter("No.", '<>%1', rStudents."No.");
                    rStudents_Aux.SetRange("Responsibility Center", rStudents."Responsibility Center");
                    if not rStudents_Aux.FindFirst then begin
                        rStudents.INSERT;
                        rStudents.InsertUsersStudent;
                    end;
                END ELSE BEGIN

                    IF iSAMS.Address <> '' THEN BEGIN
                        IF STRLEN(iSAMS.Address) <= 50 THEN
                            rStudents.VALIDATE(rStudents.Address, iSAMS.Address)
                        ELSE BEGIN
                            CLEAR(moradaaux);
                            CLEAR(Aux);
                            CLEAR(moradaComp);
                            moradaaux := iSAMS.Address;
                            Flag := FALSE;

                            WHILE (STRPOS(moradaaux, ' ') <> 0) AND (Flag = FALSE) DO BEGIN
                                Aux := COPYSTR(moradaaux, 1, STRPOS(moradaaux, ' ') - 1);
                                IF moradaComp = '' THEN
                                    moradaComp := Aux
                                ELSE BEGIN
                                    IF STRLEN(moradaComp + ' ' + Aux) > 50 THEN
                                        Flag := TRUE
                                    ELSE
                                        moradaComp := moradaComp + ' ' + Aux;
                                END;
                                moradaaux := COPYSTR(moradaaux, STRPOS(moradaaux, ' ') + 1);
                            END;
                            rStudents.VALIDATE(rStudents.Address, moradaComp);
                            rStudents.VALIDATE(rStudents."Address 2", Aux + ' ' + moradaaux);
                        END;
                    END;
                    IF (iSAMS."Post Code" <> '') AND (iSAMS."Post Code" <> '-') THEN rStudents."Post Code" := iSAMS."Post Code";
                    IF iSAMS.Location <> '' THEN rStudents.Location := iSAMS.Location;
                    IF iSAMS."NIB-IBAN" <> '' THEN BEGIN
                        IF COPYSTR(iSAMS."NIB-IBAN", 1, 2) = 'PT' THEN BEGIN
                            rStudents.VALIDATE(rStudents.IBAN, iSAMS."NIB-IBAN");
                            rStudents.VALIDATE(rStudents.NIB, COPYSTR(iSAMS."NIB-IBAN", 5));
                        END ELSE BEGIN
                            rStudents.VALIDATE(rStudents.IBAN, 'PT50' + iSAMS."NIB-IBAN");
                            rStudents.VALIDATE(rStudents.NIB, iSAMS."NIB-IBAN");
                        END;
                    END;
                    IF iSAMS."E-mail" <> '' THEN rStudents.VALIDATE(rStudents."E-mail", iSAMS."E-mail");
                    rStudents.MODIFY;

                END;


                //----------------------------------------------------------------------------------------
                //Criar os associados
                //----------------------------------------------------------------------------------------


                //////////////MAE///////////////////
                encontrou := FALSE;
                IF NomeMae <> '' THEN BEGIN
                    IF NIFMae <> '' THEN BEGIN
                        rUsersFamily.RESET;
                        rUsersFamily.SETRANGE(rUsersFamily."VAT Registration No.", NIFMae);
                        IF rUsersFamily.FINDFIRST THEN
                            encontrou := TRUE;
                    END;
                    //IT001 - Parque - 2018.02.22,sn


                    //Testar se o associado já existe pelo nome
                    IF encontrou = FALSE THEN BEGIN
                        rUsersFamily.RESET;
                        rUsersFamily.SETRANGE(rUsersFamily.Name, NomeMae);
                        IF rUsersFamily.FINDFIRST THEN
                            encontrou := TRUE;
                    END;

                    //Criar o associado Mãe
                    IF encontrou = FALSE THEN BEGIN
                        rUsersFamily.INIT;
                        rUsersFamily."No." := cNoSeriesMgt.GetNextNo(rEduConf."Users Family Nos.", 0D, TRUE);
                        rUsersFamily.VALIDATE(rUsersFamily.Name, NomeMae);
                        rUsersFamily."Phone No. 2" := TelefoneEmpMae;
                        rUsersFamily."Mobile Phone" := TelemovelMae;
                        rUsersFamily."E-mail" := "E-mailMae";


                        //IT001 - Parque - 2018.02.22,sn
                        IF iSAMS.EnderecoMae <> '' THEN BEGIN
                            IF STRLEN(iSAMS.EnderecoMae) <= 50 THEN
                                rUsersFamily.VALIDATE(rUsersFamily.Address, iSAMS.EnderecoMae)
                            ELSE BEGIN

                                CLEAR(moradaaux);
                                CLEAR(Aux);
                                CLEAR(moradaComp);
                                moradaaux := iSAMS.EnderecoMae;
                                Flag := FALSE;

                                WHILE (STRPOS(moradaaux, ' ') <> 0) AND (Flag = FALSE) DO BEGIN
                                    Aux := COPYSTR(moradaaux, 1, STRPOS(moradaaux, ' ') - 1);
                                    IF moradaComp = '' THEN
                                        moradaComp := Aux
                                    ELSE BEGIN
                                        IF STRLEN(moradaComp + ' ' + Aux) > 50 THEN
                                            Flag := TRUE
                                        ELSE
                                            moradaComp := moradaComp + ' ' + Aux;
                                    END;
                                    moradaaux := COPYSTR(moradaaux, STRPOS(moradaaux, ' ') + 1);
                                END;
                                rUsersFamily.Address := moradaComp;
                                rUsersFamily."Address 2" := Aux + ' ' + moradaaux;
                            END;
                        END;
                        IF (iSAMS.CodPostalMae <> '') AND (iSAMS.CodPostalMae <> '-') THEN
                            rUsersFamily."Post Code" := iSAMS.CodPostalMae;
                        IF iSAMS.LocalidadeMae <> '' THEN rUsersFamily.Location := iSAMS.LocalidadeMae;
                        rUsersFamily."VAT Registration No." := NIFMae;
                        //IT001 - Parque - 2018.02.22,en

                        IF ParentescoEncEdu = 2 THEN
                            rUsersFamily."VAT Registration No." := NContribuinteEncEdu;
                        rUsersFamily."Payment Method Code" := rEduConf."Payment Method Code";
                        rUsersFamily."Currency Code" := rEduConf."Currency Code";
                        rUsersFamily."Payment Terms Code" := rEduConf."Payment Terms Code";
                        rUsersFamily."Customer Disc. Group" := rEduConf."Customer Disc. Group";
                        rUsersFamily."Allow Line Disc." := rEduConf."Allow Line Disc.";
                        rUsersFamily."Customer Posting Group" := rEduConf."Customer Posting Group";
                        rUsersFamily."Gen. Bus. Posting Group" := rEduConf."Gen. Bus. Posting Group";
                        rUsersFamily."VAT Bus. Posting Group" := rEduConf."VAT Bus. Posting Group";
                        rUsersFamily.INSERT(TRUE);
                    END;


                    //Associar a mae ao aluno
                    rUsersFamilyStudents.INIT;
                    rUsersFamilyStudents."School Year" := cStudentsRegistration.GetShoolYearActive;
                    rUsersFamilyStudents."Student Code No." := rStudents."No.";
                    rUsersFamilyStudents.Kinship := rUsersFamilyStudents.Kinship::Mother;
                    rUsersFamilyStudents.VALIDATE(rUsersFamilyStudents."No.", rUsersFamily."No.");
                    IF ParentescoEncEdu = 2 THEN
                        rUsersFamilyStudents."Education Head" := TRUE;
                    if not rUsersFamilyStudents.INSERT(TRUE) then
                        rUsersFamilyStudents.Modify();
                END;

                //////////////PAI///////////////////
                encontrou := FALSE;
                IF NomePai <> '' THEN BEGIN
                    IF NIFPai <> '' THEN BEGIN
                        rUsersFamily.RESET;
                        rUsersFamily.SETRANGE(rUsersFamily."VAT Registration No.", NIFPai);
                        IF rUsersFamily.FINDFIRST THEN
                            encontrou := TRUE;
                    END;
                    //IT001 - Parque - 2018.02.22,sn


                    //Testar se o associado já existe pelo nome
                    IF encontrou = FALSE THEN BEGIN
                        rUsersFamily.RESET;
                        rUsersFamily.SETRANGE(rUsersFamily.Name, NomePai);
                        IF rUsersFamily.FINDFIRST THEN
                            encontrou := TRUE;
                    END;


                    //Criar o associado Pai
                    IF encontrou = FALSE THEN BEGIN
                        rUsersFamily.INIT;
                        rUsersFamily."No." := cNoSeriesMgt.GetNextNo(rEduConf."Users Family Nos.", 0D, TRUE);
                        rUsersFamily.VALIDATE(rUsersFamily.Name, NomePai);
                        rUsersFamily."Phone No. 2" := TelefoneEmpPai;
                        rUsersFamily."Mobile Phone" := TelemovelPai;
                        rUsersFamily."E-mail" := "E-mailPai";

                        //IT001 - Parque - 2018.02.22,sn
                        IF iSAMS.EnderecoPai <> '' THEN BEGIN
                            IF STRLEN(iSAMS.EnderecoPai) <= 50 THEN
                                rUsersFamily.VALIDATE(rUsersFamily.Address, iSAMS.EnderecoPai)
                            ELSE BEGIN

                                CLEAR(moradaaux);
                                CLEAR(Aux);
                                CLEAR(moradaComp);
                                moradaaux := iSAMS.EnderecoPai;
                                Flag := FALSE;

                                WHILE (STRPOS(moradaaux, ' ') <> 0) AND (Flag = FALSE) DO BEGIN
                                    Aux := COPYSTR(moradaaux, 1, STRPOS(moradaaux, ' ') - 1);
                                    IF moradaComp = '' THEN
                                        moradaComp := Aux
                                    ELSE BEGIN
                                        IF STRLEN(moradaComp + ' ' + Aux) > 50 THEN
                                            Flag := TRUE
                                        ELSE
                                            moradaComp := moradaComp + ' ' + Aux;
                                    END;
                                    moradaaux := COPYSTR(moradaaux, STRPOS(moradaaux, ' ') + 1);
                                END;
                                rUsersFamily.Address := moradaComp;
                                rUsersFamily."Address 2" := Aux + ' ' + moradaaux;
                            END;
                        END;
                        IF (iSAMS.CodPostalPai <> '') AND (iSAMS.CodPostalPai <> '-') THEN
                            rUsersFamily."Post Code" := iSAMS.CodPostalPai;
                        IF iSAMS.LocalidadePai <> '' THEN rUsersFamily.Location := iSAMS.LocalidadePai;
                        rUsersFamily."VAT Registration No." := NIFPai;

                        //IT001 - Parque - 2018.02.22,en

                        IF ParentescoEncEdu = 1 THEN
                            rUsersFamily."VAT Registration No." := NContribuinteEncEdu;
                        rUsersFamily."Payment Method Code" := rEduConf."Payment Method Code";
                        rUsersFamily."Currency Code" := rEduConf."Currency Code";
                        rUsersFamily."Payment Terms Code" := rEduConf."Payment Terms Code";
                        rUsersFamily."Customer Disc. Group" := rEduConf."Customer Disc. Group";
                        rUsersFamily."Allow Line Disc." := rEduConf."Allow Line Disc.";
                        rUsersFamily."Customer Posting Group" := rEduConf."Customer Posting Group";
                        rUsersFamily."Gen. Bus. Posting Group" := rEduConf."Gen. Bus. Posting Group";
                        rUsersFamily."VAT Bus. Posting Group" := rEduConf."VAT Bus. Posting Group";
                        rUsersFamily.INSERT(TRUE);
                    END;


                    //Associar o Pai ao aluno
                    rUsersFamilyStudents.INIT;
                    rUsersFamilyStudents."School Year" := cStudentsRegistration.GetShoolYearActive;
                    rUsersFamilyStudents."Student Code No." := rStudents."No.";
                    rUsersFamilyStudents.Kinship := rUsersFamilyStudents.Kinship::Father;
                    rUsersFamilyStudents.VALIDATE(rUsersFamilyStudents."No.", rUsersFamily."No.");
                    IF ParentescoEncEdu = 1 THEN
                        rUsersFamilyStudents."Education Head" := TRUE;
                    if not rUsersFamilyStudents.INSERT(TRUE) then
                        rUsersFamilyStudents.Modify();
                END;


                //END;
            end;
        }

    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }


    var
        rStudents: Record Students;
        rStudents_Aux: Record Students;
        NumAluno: Code[10];
        encontrou: Boolean;
        rUsersFamily: Record "Users Family";
        rUsersFamilyStudents: Record "Users Family / Students";
        rUsersFamilyStudents2: Record "Users Family / Students";
        cStudentsRegistration: Codeunit "Students Registration";
        rEduConf: Record "Edu. Configuration";
        cNoSeriesMgt: Codeunit NoSeriesManagement;
        Morada: Text[100];
        Aux: Text[65];
        moradaComp: Text[100];
        moradaaux: Text[100];
        Flag: Boolean;
        riSAMS: Record iSAMS;


        Text0001: Label 'Student %1 does not have a NIB and cannot be imported.';
        Text0002: Label 'You cannot import while there are duplicates.';
}
