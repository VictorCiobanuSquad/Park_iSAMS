xmlport 50100 xml_iSAMS
{
    Caption = 'Import iSAMS';
    Format = VariableText;
    FieldSeparator = '<TAB>';
    schema
    {
        textelement(RootNodeName)
        {
            tableelement(iSAMS; iSAMS)
            {

                fieldelement(BirthDate; iSAMS."Birth Date")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StudentSurname; iSAMS."Student Surname")
                {
                    MinOccurs = Zero;
                }
                fieldelement(StudentFirstname; iSAMS."Student Firstname")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Sex; iSAMS.Sex)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Address; iSAMS.Address)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Location; iSAMS.Location)
                {
                    MinOccurs = Zero;
                }
                fieldelement(PostCode; iSAMS."Post Code")
                {
                    MinOccurs = Zero;
                }
                fieldelement(Country; iSAMS.Country)
                {
                    MinOccurs = Zero;
                }
                textelement(Dummy)
                {

                    MinOccurs = Zero;
                }
                fieldelement(Forename1; iSAMS.Forename1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Surname1; iSAMS.Surname1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Forename2; iSAMS.Forename2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Surname2; iSAMS.Surname2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Relationtype; iSAMS.Relationtype)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Mobile1; iSAMS.Mobile1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Mobile2; iSAMS.Mobile2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Email1; iSAMS.Email1)
                {
                    MinOccurs = Zero;
                }
                fieldelement(Email2; iSAMS.Email2)
                {
                    MinOccurs = Zero;
                }
                fieldelement(SchoolID; iSAMS."School ID")
                {
                    MinOccurs = Zero;
                }
                fieldelement(ParentescoEncEdu; iSAMS.ParentescoEncEdu)
                {
                    MinOccurs = Zero;
                }
                fieldelement(VATRegistrationNo; iSAMS."VAT Registration No.")
                {
                    MinOccurs = Zero;
                }
                fieldelement(NIFAss; iSAMS.NIFAss)
                {
                    MinOccurs = Zero;
                }
                trigger OnBeforeInsertRecord()
                begin
                    IF iSAMS."Student Firstname" = '' THEN
                        currXMLport.SKIP;


                    nLinha := nLinha + 1;
                    iSAMS.NMov := nLinha;

                    IF rEduConfiguration.GET THEN;
                    iSAMS.Name := iSAMS."Student Firstname" + ' ' + iSAMS."Student Surname";

                    riSAMS.RESET;
                    riSAMS.SETRANGE(riSAMS.Name, iSAMS.Name);
                    riSAMS.SETFILTER(riSAMS.NMov, '<>%1', iSAMS.NMov);
                    IF NOT riSAMS.FINDFIRST THEN BEGIN
                        iSAMS."Nº Processo" := NoSeriesMgt.GetNextNo(rEduConfiguration."Student Nos.", WORKDATE, TRUE);
                    END ELSE BEGIN
                        iSAMS."Nº Processo" := riSAMS."Nº Processo";
                        iSAMS.Duplicado := TRUE;
                        riSAMS.Duplicado := TRUE;
                        riSAMS.MODIFY;
                    END;

                    IF iSAMS.Relationtype = 'Parents' THEN BEGIN
                        iSAMS.NomePai := iSAMS.Forename1 + ' ' + iSAMS.Surname1;
                        iSAMS.TelemovelPai := iSAMS.Mobile1;
                        iSAMS."E-mailPai" := iSAMS.Email1;
                        iSAMS.EnderecoPai := iSAMS.Address + ' ' + iSAMS.Address2;
                        iSAMS.CodPostalPai := iSAMS."Post Code";
                        iSAMS.LocalidadePai := iSAMS.Location;

                        iSAMS.NomeMae := iSAMS.Forename2 + ' ' + iSAMS.Surname2;
                        iSAMS.TelemovelMae := iSAMS.Mobile2;
                        iSAMS."E-mailMae" := iSAMS.Email2;
                        iSAMS.EnderecoMae := iSAMS.Address + ' ' + iSAMS.Address2;
                        iSAMS.CodPostalMae := iSAMS."Post Code";
                        iSAMS.LocalidadeMae := iSAMS.Location;
                    END;

                    IF iSAMS.Relationtype = 'Father' THEN BEGIN
                        iSAMS.NomePai := iSAMS.Forename1 + ' ' + iSAMS.Surname1;
                        iSAMS.TelemovelPai := iSAMS.Mobile1;
                        iSAMS."E-mailPai" := iSAMS.Email1;
                        iSAMS.EnderecoPai := iSAMS.Address + ' ' + iSAMS.Address2;
                        iSAMS.CodPostalPai := iSAMS."Post Code";
                        iSAMS.LocalidadePai := iSAMS.Location;
                        iSAMS.NIFPai := iSAMS.NIFAss;
                    END;

                    IF iSAMS.Relationtype = 'Mother' THEN BEGIN
                        iSAMS.NomeMae := iSAMS.Forename1 + ' ' + iSAMS.Surname1;
                        iSAMS.TelemovelMae := iSAMS.Mobile1;
                        iSAMS."E-mailMae" := iSAMS.Email1;
                        iSAMS.EnderecoMae := iSAMS.Address + ' ' + iSAMS.Address2;
                        iSAMS.CodPostalMae := iSAMS."Post Code";
                        iSAMS.LocalidadeMae := iSAMS.Location;
                        iSAMS.NIFMae := iSAMS.NIFAss;
                    END;


                    IF (iSAMS.Relationtype <> 'Parents') AND (iSAMS.Relationtype <> 'Mother') AND (iSAMS.Relationtype <> 'Father') THEN BEGIN
                        iSAMS.NomeOutro := iSAMS.Forename1 + ' ' + iSAMS.Surname1;
                        iSAMS.TelemovelOutro := iSAMS.Mobile1;
                        iSAMS."E-mailOutro" := iSAMS.Email1;
                        iSAMS.EnderecoOutro := iSAMS.Address + ' ' + iSAMS.Address2;
                        iSAMS.CodPostalOutro := iSAMS."Post Code";
                        iSAMS.LocalidadeOutro := iSAMS.Location;
                        iSAMS.NIFOutro := iSAMS.NIFAss;
                    END;


                    CASE iSAMS.ParentescoEncEdu OF
                        iSAMS.ParentescoEncEdu::Mother:
                            BEGIN
                                iSAMS."E-mail" := iSAMS."E-mailMae";
                                iSAMS.Address := iSAMS.EnderecoMae;
                                iSAMS."Post Code" := iSAMS.CodPostalMae;
                                iSAMS.Location := iSAMS.LocalidadeMae;
                                iSAMS.NContribuinteEncEdu := iSAMS.NIFMae;
                            END;
                        iSAMS.ParentescoEncEdu::Father:
                            BEGIN
                                iSAMS."E-mail" := iSAMS."E-mailPai";
                                iSAMS.Address := iSAMS.EnderecoPai;
                                iSAMS."Post Code" := iSAMS.CodPostalPai;
                                iSAMS.Location := iSAMS.LocalidadePai;
                                iSAMS.NContribuinteEncEdu := iSAMS.NIFPai;
                            END;
                        ELSE BEGIN
                            IF iSAMS.NomeMae <> '' THEN BEGIN
                                iSAMS.ParentescoEncEdu := iSAMS.ParentescoEncEdu::Mother;
                                iSAMS."E-mail" := iSAMS."E-mailMae";
                                iSAMS.Address := iSAMS.EnderecoMae;
                                iSAMS."Post Code" := iSAMS.CodPostalMae;
                                iSAMS.Location := iSAMS.LocalidadeMae;
                                iSAMS.NContribuinteEncEdu := iSAMS.NIFMae;
                            END ELSE BEGIN
                                IF iSAMS.NomePai <> '' THEN BEGIN
                                    iSAMS.ParentescoEncEdu := iSAMS.ParentescoEncEdu::Father;
                                    iSAMS."E-mail" := iSAMS."E-mailPai";
                                    iSAMS.Address := iSAMS.EnderecoPai;
                                    iSAMS."Post Code" := iSAMS.CodPostalPai;
                                    iSAMS.Location := iSAMS.LocalidadePai;
                                    iSAMS.NContribuinteEncEdu := iSAMS.NIFPai;
                                END ELSE BEGIN
                                    iSAMS.ParentescoEncEdu := iSAMS.ParentescoEncEdu::Other;
                                    iSAMS."E-mail" := iSAMS."E-mailOutro";
                                    iSAMS.Address := iSAMS.EnderecoOutro;
                                    iSAMS."Post Code" := iSAMS.CodPostalOutro;
                                    iSAMS.Location := iSAMS.LocalidadeOutro;
                                    iSAMS.NContribuinteEncEdu := iSAMS.NIFOutro;
                                END;
                            END;
                        END;
                    END;
                end;
            }

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

    trigger OnPreXmlPort()
    var
        myInt: Integer;
    begin
        riSAMS.RESET;
        riSAMS.DELETEALL;
    end;

    trigger OnPostXmlPort()
    begin

        riSAMS.RESET;
        riSAMS.SETRANGE(riSAMS.Duplicado, TRUE);
        riSAMS.SETFILTER(riSAMS.Relationtype, '<>%1', 'Parents');
        IF riSAMS.FINDSET THEN BEGIN
            REPEAT
                riSAMS2.RESET;
                riSAMS2.SETRANGE(riSAMS2."Nº Processo", riSAMS."Nº Processo");
                riSAMS2.SETRANGE(riSAMS2.Relationtype, 'Parents');
                riSAMS2.SETFILTER(riSAMS2.NMov, '<>%1', riSAMS.NMov);

                IF NOT riSAMS2.FINDFIRST THEN BEGIN
                    riSAMS.Duplicado := FALSE;
                    riSAMS.MODIFY;
                END;
            UNTIL riSAMS.NEXT = 0;
        END;
    end;

    var
        riSAMS: Record iSAMS;
        riSAMS2: Record iSAMS;

        nLinha: Integer;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        rEduConfiguration: Record "Edu. Configuration";
        NoSerie: Code[20];
}
