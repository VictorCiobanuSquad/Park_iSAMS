page 50100 "iSams List"
{
    ApplicationArea = All;
    Caption = 'iSams List';
    PageType = List;
    SourceTable = iSAMS;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Nº Processo"; Rec."Nº Processo")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field("VAT Registration No."; Rec."VAT Registration No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Birth Date field.';
                }
                field(Sex; Rec.Sex)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sex field.';
                }
                field(Address; Rec.Address)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Address field.';
                }
                field("Post Code"; Rec."Post Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Post Code field.';
                }
                field(Location; Rec.Location)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Localidade field.';
                }
                field("E-mail"; Rec."E-mail")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-mail field.';
                }
                field("NIB-IBAN"; Rec."NIB-IBAN")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NIB-IBAN field.';
                }
                field(ParentescoEncEdu; Rec.ParentescoEncEdu)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Parentesco Enc. Edu field.';
                }
                field(NContribuinteEncEdu; Rec.NContribuinteEncEdu)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the VAT Registration No. field.';
                }
                field(NomeMae; Rec.NomeMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(TelefoneEmpMae; Rec.TelefoneEmpMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. 2 field.';
                }
                field(TelemovelMae; Rec.TelemovelMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile Phone field.';
                }
                field("E-mailMae"; Rec."E-mailMae")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-mail field.';
                }
                field(EnderecoMae; Rec.EnderecoMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Endereço Mãe field.';
                }
                field(CodPostalMae; Rec.CodPostalMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cod. Postal Mãe field.';
                }
                field(LocalidadeMae; Rec.LocalidadeMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Localidade Mãe field.';
                }
                field(NIFMae; Rec.NIFMae)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NIF Mãe field.';
                }
                field(NomePai; Rec.NomePai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(TelefoneEmpPai; Rec.TelefoneEmpPai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. 2 field.';
                }
                field(TelemovelPai; Rec.TelemovelPai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile Phone field.';
                }
                field("E-mailPai"; Rec."E-mailPai")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-mail field.';
                }
                field(EnderecoPai; Rec.EnderecoPai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Endereço Pai field.';
                }
                field(CodPostalPai; Rec.CodPostalPai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cod. Postal Pai field.';
                }
                field(LocalidadePai; Rec.LocalidadePai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Localidade Pai field.';
                }
                field(NIFPai; Rec.NIFPai)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NIF Pai field.';
                }
                field(NomeOutro; Rec.NomeOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Name field.';
                }
                field(TelefoneEmpOutro; Rec.TelefoneEmpOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Phone No. 2 field.';
                }
                field(TelemovelOutro; Rec.TelemovelOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Mobile Phone field.';
                }
                field("E-mailOutro"; Rec."E-mailOutro")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the E-mail field.';
                }
                field(EnderecoOutro; Rec.EnderecoOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Endereço Outro field.';
                }
                field(CodPostalOutro; Rec.CodPostalOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Cod. Postal Outro field.';
                }
                field(LocalidadeOutro; Rec.LocalidadeOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Localidade Outro field.';
                }
                field(NIFOutro; Rec.NIFOutro)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the NIF Outro field.';
                }
                field("School ID"; Rec."School ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the School ID field.';
                }
                field(Duplicado; Rec.Duplicado)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Duplicado field.';
                }
            }
        }
    }
}
