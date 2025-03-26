Coffee.Fullupdate = { 
    Updating = false
}

function Coffee.Fullupdate:Update( )
    -- This is a simple fix to an issue caused by primarly zxcmodule but may
    -- also popup in other modules aswell. It will crash you if you lag too
    -- hard or if you force full update manually.

    self.Updating = true 

    timer.Simple( 0, function( )
        self.Updating = false
    end )
end

function Coffee.Fullupdate:IsUpdating( )
    return self.Updating
end

gameevent.Listen( 'OnRequestFullUpdate' )

Coffee.Hooks:New( 'OnRequestFullUpdate', Coffee.Fullupdate.Update, Coffee.Fullupdate )