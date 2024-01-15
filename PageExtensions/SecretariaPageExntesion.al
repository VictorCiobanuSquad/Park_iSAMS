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
                    caption = '1st Step - Import iSams from txt';
                    RunObject = xmlport "xml_iSAMS";
                }



                action("iSams List")
                {
                    ApplicationArea = All;
                    caption = '2nd Step - Verify the data';
                    RunObject = Page "iSams List";
                }


                action("import isams to database")
                {
                    ApplicationArea = All;
                    caption = '3rd Step - Import';
                    RunObject = report "import isams to database";
                }
            }

        }
    }

}
