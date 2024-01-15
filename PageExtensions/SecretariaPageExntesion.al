pageextension 50100 "Secreatria Role Center Ext" extends "Secretaria Role Center"
{

    actions
    {
        addafter("JDE Integrated")
        {
            group("Actividades Periodicas")

            {
                Caption = 'Actividades Periódicas';
                action("Import iSAMS")
                {
                    ApplicationArea = All;
                    caption = 'Import iSAMS';
                    RunObject = xmlport "xml_iSAMS";
                }
            }

        }
    }

}
