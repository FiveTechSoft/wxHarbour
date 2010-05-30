/*
 * $Id$
 *
 * TField
 *
 */

#include "wxharbour.ch"
#include "xerror.ch"

/*
	TODO: Check for a correct validation for FieldExpression, it can contain any valid
				Harbour statement/formula, and loose checking is done on SetFieldMethod
*/

#xcommand RAISE TFIELD <name> ERROR <cDescription> => ;
					RAISE ERROR E"\nTable: <" + ::FTable:ClassName() + ">, FieldExpression: <" + <name> + ">" + ;
											E"\n" + ;
											<cDescription> + E"\n" ;
								SUBSYSTEM ::ClassName + "<" + ::Name + ">"	;
								OPERATION E"\n" + ProcName(0)+"(" + LTrim(Str(ProcLine(0))) + ")"

/*
	TField
	Teo. Mexico 2009
*/
CLASS TField FROM WXHBaseClass
PRIVATE:

	DATA FActive	INIT .F.
	DATA FAutoIncrementKeyIndex
	DATA FDataOfValidValues
	DATA FDescription INIT ""
	DATA FFieldCodeBlock									// Code Block
	DATA FFieldWriteBlock									// Code Block to do WRITE
	DATA FFieldExpression									// Literal Field expression on the Database
    DATA FHasCalcFieldMethod INIT .F.
	DATA FPickList											// codeblock to help to pick a value
	DATA FGroup														// A Text label for grouping
	DATA FIsMasterFieldComponent INIT .F. // Field is a MasterField component
	DATA FKeyIndex
	DATA FLabel
	DATA FModStamp	INIT .F.							// Field is automatically mantained (dbf layer)
	DATA FPrimaryKeyComponent INIT .F.		// Field is included in a Array of fields for a Primary Index Key
	DATA FPublished INIT .T.							// Logical: Appears in user field selection
	DATA FReadOnly	INIT .F.
	DATA FRequired INIT .F.
	DATA FReUseField INIT .F.
	DATA FUniqueKeyIndex
	DATA FUsingField						// Field used on Calculated Field
	METHOD GetAutoIncrement INLINE ::FAutoIncrementKeyIndex != NIL
	METHOD GetAutoIncrementValue
	METHOD GetFieldMethod
	METHOD GetIsKeyIndex INLINE ::FKeyIndex != NIL
	METHOD GetIsPrimaryKeyField( masterSourceBaseClass ) INLINE ::Table:GetPrimaryKeyField( masterSourceBaseClass ) == Self
	METHOD GetLabel INLINE iif( ::FLabel == NIL, ::FName, ::FLabel )
	METHOD GetReadOnly INLINE ::FReadOnly
	METHOD GetUnique INLINE ::FUniqueKeyIndex != NIL
	METHOD SetAutoIncrementKeyIndex( Index ) INLINE ::FAutoIncrementKeyIndex := Index
	METHOD SetDBS_DEC( dec ) INLINE ::FDBS_DEC := dec
	METHOD SetDBS_LEN( len ) INLINE ::FDBS_LEN := len
	METHOD SetDescription( Description ) INLINE ::FDescription := Description
	METHOD SetGroup( Group ) INLINE ::FGroup := Group
	METHOD SetIsMasterFieldComponent( IsMasterFieldComponent )
	METHOD SetKeyIndex( Index ) INLINE ::FKeyIndex := Index
	METHOD SetLabel( label ) INLINE ::FLabel := label
	METHOD SetName( name )
	METHOD SetPickList( pickList )
	METHOD SetPrimaryKeyComponent( PrimaryKeyComponent )
	METHOD SetPublished( Published ) INLINE ::FPublished := Published
	METHOD SetReadOnly( ReadOnly ) INLINE ::FReadOnly := ReadOnly
	METHOD SetUniqueKeyIndex( Index ) INLINE ::FUniqueKeyIndex := Index
	METHOD SetUsingField( usingField )

PROTECTED:

	DATA FBuffer
	DATA FCalculated INIT .F.
	DATA FChanged INIT .F.
	DATA FDefaultValue
	DATA FDBS_DEC INIT 0
	DATA FDBS_LEN
	DATA FDBS_NAME
	DATA FDBS_TYPE
	DATA FEvtOnBeforeChange
	DATA FFieldArrayIndex								// Array of TField's indexes in FieldList
	DATA FFieldMethodType
	DATA FFieldReadBlock								// Code Block to do READ
	DATA FName INIT ""
	DATA FTable
	DATA FTableBaseClass
	DATA FType INIT "TField"
	DATA FValType INIT "U"
	DATA FWrittenValue
	
	METHOD GetCloneData( cloneData )
	METHOD GetDefaultValue( defaultValue )
    METHOD GetDBS_LEN INLINE ::FDBS_LEN
    METHOD GetDBS_TYPE INLINE ::FDBS_TYPE
	METHOD GetEmptyValue BLOCK {|| NIL }
	METHOD GetFieldArray()
	METHOD GetFieldReadBlock()
	METHOD GetLinkedTable() INLINE NIL
	METHOD GetUndoValue()
	METHOD SetAsString( string ) INLINE ::SetAsVariant( string )
	METHOD SetBuffer( value )
	METHOD SetCloneData( cloneData )
	METHOD SetDefaultValue( DefaultValue ) INLINE ::FDefaultValue := DefaultValue
	METHOD SetRequired( Required ) INLINE ::FRequired := Required
	METHOD SetReUseField( reUseField ) INLINE ::FReUseField := reUseField

PUBLIC:

	DATA nameAlias
	DATA Picture

	CONSTRUCTOR New( Table, curBaseClass )

	METHOD AddFieldMessage()
	METHOD Delete
	METHOD GetAsString INLINE "<" + ::ClassName + ">"
	METHOD GetAsVariant( ... )
	METHOD GetBuffer()
	METHOD GetEditText
	METHOD GetData()
	METHOD GetKeyVal( keyVal )
	METHOD GetValidValues
    METHOD IndexExpression()
	METHOD IsReadOnly() INLINE ::FTable:ReadOnly .OR. ::FReadOnly .OR. ( ::FTable:State != dsBrowse .AND. ::AutoIncrement )
    METHOD IsTableField()
	METHOD IsValid( showAlert )
	METHOD OnPickList( param )
	METHOD Reset()
	METHOD SetAsVariant( value )
	METHOD SetData( Value )
	METHOD SetEditText( Text )
	METHOD SetFieldMethod( FieldMethod, calculated )
	METHOD SetKeyVal( keyVal )
	METHOD ValidateFieldInfo VIRTUAL

	PROPERTY AsString READ GetAsString WRITE SetAsString
	PROPERTY AsVariant READ GetAsVariant WRITE SetAsVariant
	PROPERTY Calculated READ FCalculated
	PROPERTY CloneData READ GetCloneData WRITE SetCloneData
	PROPERTY DisplayText READ GetEditText
	PROPERTY EmptyValue READ GetEmptyValue
	PROPERTY KeyVal READ GetKeyVal WRITE SetKeyVal
	PROPERTY LinkedTable READ GetLinkedTable
	PROPERTY PickList READ FPickList WRITE SetPickList
	PROPERTY ReUseField READ FReUseField WRITE SetReUseField
	PROPERTY IsKeyIndex READ GetIsKeyIndex
	PROPERTY IsMasterFieldComponent READ FIsMasterFieldComponent WRITE SetIsMasterFieldComponent
	PROPERTY IsPrimaryKeyField READ GetIsPrimaryKeyField
	PROPERTY RawDefaultValue READ FDefaultValue
	PROPERTY Text READ GetEditText WRITE SetEditText
	PROPERTY UndoValue READ GetUndoValue
	PROPERTY Value READ GetAsVariant WRITE SetAsVariant
	PROPERTY WrittenValue READ FWrittenValue

PUBLISHED:
	
	DATA IncrementBlock
	DATA OnGetIndexKeyVal
	/*
	 * Event holders
	 */
	DATA OnGetText			// Params: Sender: TField, Text: String
	DATA OnSearch			// Search in indexed field
	DATA OnSetText			// Params: Sender: TField, Text: String
	DATA OnSetValue			// Parama:
	DATA OnAfterChange				// Params: Sender: TField
	DATA OnValidate			// Params: Sender: TField
	
	DATA ValidValues

	PROPERTY AutoIncrement READ GetAutoIncrement
	PROPERTY AutoIncrementKeyIndex READ FAutoIncrementKeyIndex WRITE SetAutoIncrementKeyIndex
	PROPERTY Changed READ FChanged
	PROPERTY DBS_DEC READ FDBS_DEC WRITE SetDBS_DEC
	PROPERTY DBS_LEN READ GetDBS_LEN WRITE SetDBS_LEN
	PROPERTY DBS_NAME READ FDBS_NAME
	PROPERTY DBS_TYPE READ GetDBS_TYPE
	PROPERTY DefaultValue READ GetDefaultValue WRITE SetDefaultValue
	PROPERTY Description READ FDescription WRITE SetDescription
	PROPERTY FieldArray READ GetFieldArray WRITE SetFieldMethod
	PROPERTY FieldCodeBlock READ FFieldCodeBlock WRITE SetFieldMethod
	PROPERTY FieldExpression READ FFieldExpression WRITE SetFieldMethod
	PROPERTY FieldMethod READ GetFieldMethod WRITE SetFieldMethod
	PROPERTY FieldMethodType READ FFieldMethodType
	PROPERTY FieldReadBlock READ GetFieldReadBlock
    PROPERTY FieldWriteBlock READ FFieldWriteBlock
	PROPERTY Group READ FGroup WRITE SetGroup
	PROPERTY KeyIndex READ FKeyIndex WRITE SetKeyIndex
	PROPERTY Label READ GetLabel WRITE SetLabel
	PROPERTY Name READ FName WRITE SetName
	PROPERTY PrimaryKeyComponent READ FPrimaryKeyComponent WRITE SetPrimaryKeyComponent
	PROPERTY Published READ FPublished WRITE SetPublished
	PROPERTY ReadOnly READ GetReadOnly WRITE SetReadOnly
	PROPERTY Required READ FRequired WRITE SetRequired
	PROPERTY Table READ FTable
	PROPERTY TableBaseClass READ FTableBaseClass
	PROPERTY Type READ FType
	PROPERTY Unique READ GetUnique
	PROPERTY UniqueKeyIndex READ FUniqueKeyIndex WRITE SetUniqueKeyIndex
	PROPERTY UsingField READ FUsingField WRITE SetUsingField
	PROPERTY ValType READ FValType

ENDCLASS

/*
	New
	Teo. Mexico 2006
*/
METHOD New( Table, curBaseClass ) CLASS TField

	::FTable := Table
	::FTableBaseClass := curBaseClass

	/* Set default field name */
	/*

	n := 0
	::FName := ""

	FOR EACH e IN ::FTable:FieldList
		IF e:ClassName == ::ClassName
			n++
		ENDIF
	NEXT

	::FName := SubStr( ::ClassName, 2 ) + LTrim( Str( n ) )
	*/

	::FActive := .T.

RETURN Self

/*
	AddFieldMessage
	Teo. Mexico 2010
*/
METHOD PROCEDURE AddFieldMessage() CLASS TField
	::FTable:AddFieldMessage( ::Name, Self )
RETURN

/*
	Delete
	Teo. Mexico 2009
*/
METHOD PROCEDURE Delete CLASS TField
	LOCAL errObj

	IF AScan( { dsEdit, dsInsert }, ::Table:State ) = 0
		::Table:Table_Not_In_Edit_or_Insert_mode()
		RETURN
	ENDIF

	IF !::FFieldMethodType = 'C' .OR. ::FCalculated .OR. ::FFieldWriteBlock == NIL .OR. ::FModStamp
		RETURN
	ENDIF

	BEGIN SEQUENCE WITH {|oErr| Break( oErr ) }

		::Table:Alias:Eval( ::FFieldWriteBlock, ::EmptyValue() )

		::Reset()

	RECOVER USING errObj

		SHOW ERROR errObj

	END

RETURN

/*
	GetAsVariant
	Teo. Mexico 2006
*/
METHOD FUNCTION GetAsVariant( ... ) CLASS TField
	LOCAL AField
	LOCAL i
	LOCAL Result
	LOCAL value

	//::SyncToContainerField()
	
	SWITCH ::FFieldMethodType
	CASE "A"
		/*
		 * This will ONLY work when all the items are of TStringField type
		 */
		Result := ""
		FOR EACH i IN ::FFieldArrayIndex
			AField := ::FTable:FieldList[ i ]
			value := AField:GetAsVariant()
			IF !HB_IsString( value )
				Result += AField:AsString
			ELSE
				Result += value
			ENDIF
		NEXT
		EXIT
	CASE "B"
		IF ::FUsingField == NIL
			Result := ::FTable:Alias:Eval( ::FFieldCodeBlock, ::FTable )
			IF HB_IsObject( Result )
				Result := Result:Value
			ENDIF
		ELSE
			Result := ::FFieldCodeBlock:Eval( ::FUsingField:Value )
		ENDIF
			EXIT
	CASE "C"
		IF ::FCalculated
			Result := ::FTable:Alias:Eval( ::FieldReadBlock, ::FTable, ... )
		ELSE
			Result := ::GetBuffer()
		ENDIF
		EXIT
	OTHERWISE
		RAISE TFIELD ::Name ERROR "GetAsVariant(): Field Method Type not supported: " + ::FFieldMethodType
	END

RETURN Result

/*
	GetAutoIncrementValue
	Teo. Mexico 2009
*/
METHOD FUNCTION GetAutoIncrementValue CLASS TField
	LOCAL AIndex
	LOCAL value

	AIndex := ::FAutoIncrementKeyIndex

	value := ::Table:Alias:Get4SeekLast(	{|| ::FieldReadBlock:Eval() }, AIndex:MasterKeyVal, AIndex:TagName )

	IF ::IncrementBlock = NIL
		value := Inc( value )
	ELSE
		value := ::IncrementBlock:Eval( value )
	ENDIF

RETURN value

/*
	GetBuffer
	Teo. Mexico 2009
*/
METHOD FUNCTION GetBuffer() CLASS TField
	LOCAL i

	/* FieldArray's doesn't have a absolute FBuffer */
	IF ::FFieldMethodType = "A"
		IF ::FBuffer = NIL
			::FBuffer := Array( Len( ::FFieldArrayIndex ) )
		ENDIF
		FOR EACH i IN ::FFieldArrayIndex
			::FBuffer[ i:__enumIndex ] := ::FTable:FieldList[ i ]:GetBuffer()
		NEXT
		RETURN ::FBuffer
	ENDIF

	IF ::FBuffer == NIL
		::Reset()
	ENDIF

RETURN ::FBuffer

/*
	GetCloneData
	Teo. Mexico 2010
*/
METHOD FUNCTION GetCloneData( cloneData ) CLASS TField

	IF cloneData = NIL
		cloneData := {=>}
	ENDIF
	
	cloneData["Buffer"] := ::FBuffer
	cloneData["Changed"] := ::FChanged
	cloneData["DefaultValue"] := ::FDefaultValue
	cloneData["WrittenValue"] := ::FWrittenValue

RETURN cloneData

/*
	GetData
	Teo. Mexico 2006
*/
METHOD PROCEDURE GetData() CLASS TField
	LOCAL i

	SWITCH ::FFieldMethodType
	CASE 'B'
		::SetBuffer( ::GetAsVariant() )
		EXIT
	CASE 'C'
		IF ::FCalculated
			::SetBuffer( ::GetAsVariant() )
		ELSE
			::SetBuffer( ::Table:Alias:Eval( ::FieldReadBlock ) )
			::FChanged := .F.
		ENDIF
		EXIT
	CASE 'A'
		FOR EACH i IN ::FFieldArrayIndex
			::FTable:FieldList[ i ]:GetData()
		NEXT
		EXIT
	END
	
	::FWrittenValue := NIL

RETURN

/*
	GetDefaultValue
	Teo. Mexico 2009
*/
METHOD FUNCTION GetDefaultValue( defaultValue ) CLASS TField
	LOCAL i
	LOCAL validValues

	IF ::FFieldMethodType = 'A'
		FOR EACH i IN ::FFieldArrayIndex
			::FTable:FieldList[ i ]:GetDefaultValue()
		NEXT
		//RETURN NIL
	ENDIF

	IF defaultValue = NIL
		IF ValType( ::FDefaultValue ) = "B"
			defaultValue := ::FDefaultValue:Eval( Self:FTable )
		ELSE
			defaultValue := ::FDefaultValue
		ENDIF
	ENDIF
	
	validValues := ::GetValidValues()
	
	IF ! Empty( validValues )
		SWITCH ValType( validValues )
		CASE 'A'
			IF defaultValue = NIL
				defaultValue := validValues[ 1 ]
			ELSEIF AScan( validValues, {|e| e == defaultValue } ) = 0
				RAISE ERROR "On field <" + ::Table:ClassName() + ":" + ::Name + ">, default value '" + defaultValue + "' is not in valid values array list"
			ENDIF
			EXIT
		CASE 'H'
			IF defaultValue = NIL
				defaultValue := HB_HKeys( validValues )[ 1 ]
			ELSE
				IF !HB_HHasKey( validValues, defaultValue )
					RAISE ERROR "On field <" + ::Table:ClassName() + ":" + ::Name + ">, default value '" + defaultValue + "' is not in valid values hash list"
				ENDIF
			ENDIF
			EXIT
		ENDSWITCH
	ENDIF

RETURN defaultValue

/*
	GetEditText
	Teo. Mexico 2009
*/
METHOD FUNCTION GetEditText CLASS TField
	LOCAL Result

	IF ::OnGetText != NIL
		Result := ::GetAsVariant()
		::OnGetText:Eval( Self, @Result )
	ELSE
		Result := ::GetAsString()
	ENDIF

RETURN Result

/*
	GetFieldArray
	Teo. Mexico 2010
*/
METHOD FUNCTION GetFieldArray() CLASS TField
	LOCAL a := {}
	LOCAL i
	
	FOR EACH i IN ::FFieldArrayIndex
		AAdd( a, ::FTable:FieldList[ i ] )
	NEXT

RETURN a

/*
	GetFieldMethod
	Teo. Mexico 2006
*/
METHOD FUNCTION GetFieldMethod CLASS TField
	SWITCH ::FFieldMethodType
	CASE 'A'
		RETURN ::FFieldArrayIndex
	CASE 'B'
		RETURN ::FFieldCodeBlock
	CASE 'C'
		RETURN ::FFieldExpression
	END
RETURN NIL

/*
	GetFieldReadBlock
	Teo. Mexico 2010
*/
METHOD FUNCTION GetFieldReadBlock() CLASS TField
	IF ::FFieldReadBlock == NIL .AND. ::FCalculated
		IF __ObjHasMsgAssigned( ::FTable, "CalcField_" + ::FName )
			::FFieldReadBlock := &("{|o,...|" + "o:CalcField_" + ::FName + "( ... ) }")
		ELSE
			IF __ObjHasMsgAssigned( ::FTable:MasterSource, "CalcField_" + ::FName )
				::FFieldReadBlock := &("{|o,...|" + "o:MasterSource:CalcField_" + ::FName + "( ... ) }")
			ELSE
				IF !::IsDerivedFrom("TObjectField")
					RAISE TFIELD ::Name ERROR "Unable to Solve Undefined Calculated Field: "
				ENDIF
			ENDIF
		ENDIF
	ENDIF
RETURN ::FFieldReadBlock

/*
	GetKeyVal
	Teo. Mexico 2010
*/
METHOD FUNCTION GetKeyVal( keyVal ) CLASS TField
	LOCAL AField
	LOCAL i

	IF keyVal == NIL
		IF ::FFieldMethodType = "A"
			keyVal := ""
			FOR EACH i IN ::FFieldArrayIndex
				AField := ::FTable:FieldList[ i ]
				keyVal += AField:GetKeyVal()
			NEXT
		ELSE
			keyVal := ::GetAsVariant()
		ENDIF
	ENDIF
	
	IF ::OnGetIndexKeyVal != NIL
		keyVal := ::OnGetIndexKeyVal:Eval( keyVal )
	ENDIF

	SWITCH ValType( keyVal )
	CASE 'C'
	CASE 'M'
		RETURN keyVal
	CASE 'D'
		RETURN DToS( keyVal )
    CASE 'T'
        RETURN HB_TToS( keyVal )
	OTHERWISE
		keyVal := AsString( keyVal )
	ENDSWITCH

RETURN keyVal

/*
	GetUndoValue
	Teo. Mexico 2009
*/
METHOD FUNCTION GetUndoValue() CLASS TField
	IF !Empty( ::FTable:UndoList ) .AND. HB_HHasKey( ::FTable:UndoList, ::FName )
		RETURN ::FTable:UndoList[ ::FName ]
	ENDIF
RETURN NIL

/*
	GetValidValues
	Teo. Mexico 2009
*/
METHOD FUNCTION GetValidValues() CLASS TField

	IF ValType( ::ValidValues ) = "B"
		IF ::FDataOfValidValues == NIL
			::FDataOfValidValues := ::ValidValues:Eval( Self )
		ENDIF
		RETURN ::FDataOfValidValues
	ENDIF

RETURN ::ValidValues

/*
    IndexExpression
    Teo. Mexico 2010
*/
METHOD FUNCTION IndexExpression() CLASS TField
    LOCAL exp
    LOCAL i
    
    IF ::FFieldMethodType = "A"
        exp := ""
		FOR EACH i IN ::FFieldArrayIndex
			exp += ::FTable:FieldList[ i ]:IndexExpression
		NEXT
    ELSE
        exp := ::FFieldExpression
    ENDIF

RETURN exp

/*
    IsTableField
    Teo. Mexico 2010
*/
METHOD FUNCTION IsTableField() CLASS TField
RETURN ::FFieldMethodType = "C" .AND. !::FCalculated

/*
	IsValid
	Teo. Mexico 2009
*/
METHOD FUNCTION IsValid( showAlert ) CLASS TField
	LOCAL validValues
	LOCAL value
	LOCAL result

	value := ::GetBuffer()
	
	IF ::FRequired .AND. Empty( value )
		IF showAlert == .T.
			wxhAlert( ::FTable:ClassName + ":" + ::FName + " <empty key value>" )
		ENDIF
		RETURN .F.
	ENDIF

	IF ::Unique
	/* IF Empty( value )
		wxhAlert( ::FTable:ClassName + ":" + ::FName + " <empty INDEX key value>" )
		RETURN .F.
	ENDIF
	 */		 
		IF ::FUniqueKeyIndex:ExistKey( ::GetKeyVal( value ) )
			IF showAlert == .T.
				wxhAlert( ::FTable:ClassName + ":" + ::FName + " <key value already exists> '" + AsString( value ) + "'")
			ENDIF
			RETURN .F.
		ENDIF
	ENDIF

	IF ::ValidValues != NIL
	
		validValues := ::GetValidValues()
			
		SWITCH ValType( validValues )
		CASE 'A'
			result := AScan( validValues, {|e| e == value } ) > 0
			EXIT
		CASE 'H'
			result := AScan( HB_HKeys( validValues ), {|e| e == value } ) > 0
			EXIT
		OTHERWISE
			wxhAlert( ::FTable:ClassName + ":" + ::FName + " <Illegal value in 'ValidValues'> " )
			RETURN .F.
		ENDSWITCH
		
		IF !result
			IF showAlert == .T.
				wxhAlert( ::FTable:ClassName + ":" + ::FName + " < value given not in 'ValidValues'> : '" + AsString( value ) + "'" )
			ENDIF
			RETURN .F.
		ENDIF

	ENDIF

	IF ::OnValidate == NIL
		RETURN .T.
	ENDIF

RETURN ::OnValidate:Eval( Self )

/*
	OnPickList
	Teo. Mexico 2009
*/
METHOD FUNCTION OnPickList( param ) CLASS TField

	IF ::FPickList == NIL
		RETURN NIL
	ENDIF
	
	SWITCH ValType( ::FPickList )
	CASE 'B'
		RETURN ::FPickList:Eval( param )
	CASE 'L'
		RETURN ::FTable:OnPickList( param )
	END

RETURN NIL

/*
	Reset
	Teo. Mexico 2009
*/
METHOD FUNCTION Reset() CLASS TField
	LOCAL AField
	LOCAL i
	LOCAL value
	LOCAL result := .F.
    
    IF !::FCalculated

        IF ::FDefaultValue = NIL

            /* if is a masterfield component, then *must* resolve it in the MasterSource(s) */
            IF ( result := ::IsMasterFieldComponent )

                result := ( AField := ::FTable:FindMasterSourceField( ::Name ) ) != NIL

                IF result

                    value := AField:GetBuffer()
                    /*
                     * if there is a DefaultValue this is ignored (may be a warning is needed)
                     */
                ENDIF

            ENDIF

            /* reset was not succesfull yet */
            IF !result
                /* resolve each field on a array of fields */
                IF ::FFieldMethodType = 'A'

                    result := .T.

                    FOR EACH i IN ::FFieldArrayIndex
                        IF result
                            result := ::FTable:FieldList[ i ]:Reset()
                        ENDIF
                    NEXT

                    RETURN result

                ELSE

                    IF ::IsDerivedFrom("TObjectField") .AND. ::IsMasterFieldComponent
                        IF ::FTable:MasterSource = NIL
                            RAISE ERROR "MasterField component '" + ::Table:ClassName + ":" + ::Name + "' needs a MasterSource Table."
                        ELSE
    //						RAISE ERROR "MasterField component '" + ::Table:ClassName + ":" + ::Name + "' cannot be resolved in MasterSource Table (" + ::FTable:MasterSource:ClassName() + ") ."
                        ENDIF
                    ENDIF

                    IF ::IsDerivedFrom( "TObjectField" )
                        IF ::LinkedTable:GetPrimaryKeyField() != NIL
                            value := ::LinkedTable:GetPrimaryKeyField():GetDefaultValue()
                            IF value == NIL
                                value := ::LinkedTable:GetPrimaryKeyField():GetEmptyValue()
                            ENDIF
                        ENDIF
                    ELSE
                        value := ::GetDefaultValue()
                        IF value = NIL
                            value := ::GetEmptyValue()
                        ENDIF
                    ENDIF

                    result := .T.

                ENDIF
            ENDIF

        ELSE

            value := ::GetDefaultValue()

            result := .T.

        ENDIF

        ::SetBuffer( value )

        ::FChanged := .F.
        ::FWrittenValue := NIL

    ENDIF

RETURN result

/*
	SetAsVariant
	Teo. Mexico 2010
*/
METHOD PROCEDURE SetAsVariant( value ) CLASS TField
	LOCAL oldState

	IF ::IsReadOnly .OR. ::FTable:State = dsInactive
		RETURN
	ENDIF

    IF ::FCalculated
        ::SetData( value )
        RETURN
    ENDIF

	IF ::FTable:State = dsBrowse .AND. ::FTable:autoEdit
		oldState := ::FTable:State
		::FTable:Edit()
	ENDIF
	
	SWITCH ::FTable:State
	CASE dsBrowse

		::SetKeyVal( value )
		
		EXIT

	CASE dsEdit
	CASE dsInsert

		SWITCH ::FFieldMethodType
		CASE "A"

			RAISE TFIELD ::Name ERROR "Trying to assign a value to a compound TField."

			EXIT

		CASE "C"

			/* Check if we are really changing values here */
			IF !value == ::GetBuffer()
				::SetData( value )
			ENDIF

		ENDSWITCH
		
		EXIT

	OTHERWISE

		RAISE TFIELD ::Name ERROR "Table not in Edit or Insert or Reading mode"

	ENDSWITCH
	
	IF oldState != NIL
		::FTable:Post()
	ENDIF

RETURN

/*
	SetBuffer
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetBuffer( value ) CLASS TField
	LOCAL itm

	/* FieldArray's doesn't have a absolute FBuffer */
	IF ::FFieldMethodType = "A"
		SWITCH ValType( value )
		CASE 'A'
			FOR EACH itm IN value
				::FTable:FieldList[ ::FFieldArrayIndex[ itm:__enumIndex ] ]:SetBuffer( itm )
			NEXT
			EXIT
		ENDSWITCH
		RETURN
	ENDIF

	IF !( hb_IsNIL( value ) .OR. ValType( value ) = ::FValType ) .AND. ;
		 ( ::IsDerivedFrom("TStringField") .AND. AScan( {"C","M"}, ValType( value ) ) = 0 )
		RAISE TFIELD ::Name ERROR "Wrong Type Assign: [" + value:ClassName + "] to <" + ::ClassName + ">"
	ENDIF

	::FBuffer := value

	IF ::OnSetValue != NIL
		::OnSetValue:Eval( Self, @::FBuffer )
	ENDIF

RETURN

/*
	SetCloneData
	Teo. Mexico 2010
*/
METHOD PROCEDURE SetCloneData( cloneData ) CLASS TField

	::FBuffer := cloneData["Buffer"]
	::FChanged := cloneData["Changed"]
	::FDefaultValue := cloneData["DefaultValue"]
	::FWrittenValue := cloneData["WrittenValue"]

RETURN

/*
	SetData
	Teo. Mexico 2006
*/
METHOD PROCEDURE SetData( Value ) CLASS TField
	LOCAL i
	LOCAL nTries
	LOCAL errObj
	LOCAL buffer

	/* SetData is only for the physical fields on the database */
	SWITCH ::FFieldMethodType
	CASE 'A'

		IF Value != NIL
			RAISE TFIELD ::Name ERROR "SetData: Not allowed custom value in a compound TField..."
		ENDIF

		FOR EACH i IN ::FFieldArrayIndex
			::FTable:FieldList[ i ]:SetData()
		NEXT
		
		RETURN

	CASE 'C'

		EXIT

	OTHERWISE

		RETURN

	ENDSWITCH

	IF !::FCalculated .AND. AScan( { dsEdit, dsInsert }, ::Table:State ) = 0
		RAISE TFIELD ::Name ERROR "SetData(): Table not in Edit or Insert mode..."
		RETURN
	ENDIF

	IF ( ::FCalculated .AND. !::FHasCalcFieldMethod ) .OR. ::FReadOnly .OR. ::FModStamp
		RETURN
	ENDIF

	IF ::AutoIncrement

		IF Value != NIL
			RAISE TFIELD ::Name ERROR "Not allowed custom value in AutoIncrement Field..."
		ENDIF

		/*
		 *AutoIncrement field writting allowed only in Adding
		 */
		IF !( ::FTable:SubState = dssAdding )
			RETURN
		ENDIF
		
		/* Try to obtain a unique key */
		nTries := 1000
		WHILE .T.
			Value := ::GetAutoIncrementValue()
			IF !::FAutoIncrementKeyIndex:ExistKey( ::GetKeyVal( Value ) )
				EXIT
			ENDIF
			IF	(--nTries = 0)
				RAISE TFIELD ::Name ERROR "Can't create AutoIncrement Value..."
				RETURN
			ENDIF
		ENDDO

	ELSE

		IF Value == NIL
			Value := ::GetBuffer()
		ENDIF

	ENDIF

	/* Don't bother... */
	IF Value == ::FWrittenValue
		RETURN
	ENDIF

	/* Check if field is a masterkey in child tables */
	IF ::FTable:PrimaryIndex != NIL .AND. ::FTable:PrimaryIndex:UniqueKeyField == Self .AND. ::FWrittenValue != NIL
		IF ::FTable:HasChilds()
			wxhAlert( "Can't modify key <"+::FName+"> with "+Value+";Has dependant child tables.")
			RETURN
		ENDIF
	ENDIF

	IF ::FEvtOnBeforeChange = NIL
		::FEvtOnBeforeChange := __ObjHasMsgAssigned( ::FTable, "OnBeforeChange_Field_" + ::Name )
	ENDIF

	IF ::FEvtOnBeforeChange .AND. !__ObjSendMsg( ::FTable, "OnBeforeChange_Field_" + ::Name, Self, Value )
		RETURN
	ENDIF

	buffer := ::GetBuffer()

	::SetBuffer( Value )

	/* Validate before the physical writting */
	IF !::IsValid( .T. )
		::SetBuffer( buffer )  // revert the change
		RETURN
	ENDIF

	BEGIN SEQUENCE WITH {|oErr| Break( oErr ) }

		/*
		 * Check for a key violation
		 */
		IF ::IsPrimaryKeyField .AND. ::FUniqueKeyIndex:ExistKey( ::GetKeyVal() )
			RAISE TFIELD ::Name ERROR "Key violation."
		ENDIF

		/* The physical write to the field */
		::FTable:Alias:Eval( ::FFieldWriteBlock, Value )

		::FWrittenValue := ::GetBuffer() // If TFieldString then we make sure that size values are equal

		/* fill undolist */
		IF ::FTable:State = dsEdit
			IF ! HB_HHasKey( ::FTable:UndoList, ::FName )
				::FTable:UndoList[ ::FName ] := buffer
			ENDIF
			::FChanged := ! Value == ::FTable:UndoList[ ::FName ]
		ENDIF

		/*
		 * Check if has to propagate change to child sources
		 */
		IF ::FTable:PrimaryIndex != NIL .AND. ::FTable:PrimaryIndex:UniqueKeyField == Self
			::FTable:SyncDetailSources()
		ENDIF

		IF ::OnAfterChange != NIL
			::OnAfterChange:Eval( Self, buffer )
		ENDIF

	RECOVER USING errObj

		SHOW ERROR errObj

	END SEQUENCE

	/* masterkey field's aren't changed here */
	IF ::IsMasterFieldComponent
		::Reset()  /* retrieve the masterfield value */
	ENDIF

RETURN

/*
	SetEditText
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetEditText( Text ) CLASS TField

	IF ::OnSetText != NIL
		::OnSetText:Eval( Self, Text )
	ELSE
		::SetAsString( Text )
	ENDIF

RETURN

/*
	SetFieldMethod
	Teo. Mexico 2006
*/
METHOD PROCEDURE SetFieldMethod( FieldMethod, calculated ) CLASS TField
	LOCAL itm,fieldName
	LOCAL AField
	LOCAL i
	LOCAL n
    LOCAL calcMethod

	SWITCH (::FFieldMethodType := ValType( FieldMethod ))
	CASE "A"

		//::FReadOnly := .T.
		::FFieldArrayIndex := {}
		fieldName := ""
		FOR EACH itm IN FieldMethod
			AField := ::FTable:FieldByName( itm, @i )
			IF AField != NIL
				AAdd( ::FFieldArrayIndex, i )
				fieldName += itm + ";"
			ELSE
				RAISE TFIELD itm ERROR "Field is not defined yet..."
			ENDIF
		NEXT
		::Name := Left( fieldName, Len( fieldName ) - 1 )
		::FFieldCodeBlock	 := NIL
		::FFieldReadBlock	 := NIL
		::FFieldWriteBlock := NIL
		::FFieldExpression := NIL

		EXIT

	CASE "B"
		::FReadOnly := .T.
		::FFieldArrayIndex := NIL
		::FFieldCodeBlock	 := FieldMethod
		::FFieldReadBlock	 := NIL
		::FFieldWriteBlock := NIL
		::FFieldExpression := NIL

		EXIT

	CASE "C"

		::FFieldArrayIndex := NIL
		::FFieldCodeBlock := NIL

		FieldMethod := LTrim( RTrim( FieldMethod ) )
        
        calcMethod := __ObjHasMsgAssigned( ::FTable, "CalcField_" + FieldMethod )

        ::FCalculated := ( calculated == .T. ) .OR. calcMethod

		IF ! ::FCalculated

            IF ::FTable:Alias != NIL
                
                IF ::FTable:Alias:FieldPos( FieldMethod ) = 0
                    RAISE TFIELD FieldMethod ERROR "Field does not exist in table..."
                ENDIF

                /* Check if the same FieldExpression is declared redeclared in the same table baseclass */
                FOR EACH AField IN ::FTable:FieldList
                    IF !Empty( AField:FieldExpression ) .AND. ;
                         Upper( AField:FieldExpression ) == Upper( FieldMethod ) .AND. ;
                         AField:TableBaseClass == ::FTableBaseClass .AND. !::FReUseField
                        RAISE TFIELD ::Name ERROR "Atempt to Re-Use FieldExpression (same field on db) <" + ::ClassName + ":" + FieldMethod + ">"
                    ENDIF
                NEXT

                ::FDBS_NAME := FieldMethod

                ::FFieldReadBlock := FieldBlock( FieldMethod )
                ::FFieldWriteBlock := FieldBlock( FieldMethod )

                n := AScan( ::Table:DbStruct, {|e| Upper( FieldMethod ) == e[1] } )

                ::FModStamp	:= ::Table:DbStruct[n][2] $ "=^+"

                ::FDBS_LEN := ::Table:DbStruct[n][3]
                ::FDBS_DEC := ::Table:DbStruct[n][4]

                IF ::IsDerivedFrom("TStringField")
                    IF ::IsDerivedFrom("TMemoField")
                        ::FSize := 0
                    ELSE
                        ::FSize := ::FDBS_LEN
                    ENDIF
                ENDIF
                
            ELSE

                ::FDBS_NAME := FieldMethod

                ::FFieldReadBlock := FieldBlock( FieldMethod )
                ::FFieldWriteBlock := FieldBlock( FieldMethod )

            ENDIF
            
        ELSE
        
            IF calcMethod
                
                ::FHasCalcFieldMethod := .T.
                ::FFieldWriteBlock := {|value| __ObjSendMsg( ::FTable, "CalcField_" + FieldMethod, value ) }
            ENDIF

		ENDIF

		fieldName := iif( Empty( ::FName ), FieldMethod, ::FName )

		IF Empty( fieldName )
			RAISE TFIELD "<Empty>" ERROR "Empty field name and field method."
		ENDIF

		::FFieldExpression := FieldMethod
		::Name := FieldMethod

		EXIT

	ENDSWITCH

RETURN

/*
	SetIsMasterFieldComponent
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetIsMasterFieldComponent( IsMasterFieldComponent ) CLASS TField
	LOCAL i

	SWITCH ::FFieldMethodType
	CASE 'A'
		FOR EACH i IN ::FFieldArrayIndex
			::FTable:FieldList[ i ]:IsMasterFieldComponent := IsMasterFieldComponent
		NEXT
	CASE 'C'
		::FIsMasterFieldComponent := IsMasterFieldComponent
	END
	
	IF ::IsDerivedFrom("TObjectField") .AND. Empty( ::FTable:GetMasterSourceClassName() )
		RAISE TFIELD ::Name ERROR "ObjectField's needs a valid MasterSource table."
	ENDIF

RETURN

/*
	SetKeyVal
	Teo. Mexico 2010
*/
METHOD FUNCTION SetKeyVal( keyVal ) CLASS TField

	IF ::IsKeyIndex
	
		IF ::OnSearch != NIL
			::OnSearch:Eval( Self )
		ENDIF

		IF !Empty( keyVal )
			IF !::KeyIndex:KeyVal == keyVal
				::KeyIndex:Seek( keyVal )
			ENDIF
		ELSE
			::FTable:DbGoTo( 0 )
		ENDIF

		IF ::FTable:LinkedObjField != NIL

			::FTable:LinkedObjField:SetAsVariant( ::FTable:GetPrimaryKeyField():GetBuffer() )

			IF ! ::FTable:LinkedObjField:GetKeyVal() == ::FTable:GetPrimaryKeyField():GetKeyVal()
				::FTable:Seek( ::FTable:LinkedObjField:GetAsVariant, "" )
			ENDIF
			
		ENDIF

	ELSE

		//RAISE TFIELD ::Name ERROR "Field has no Index in the Table..."
		wxhAlert( "Field '" + ::FName + "' has no Index in the '" + ::FTable:ClassName() + "' Table..." )

	ENDIF

RETURN Self

/*
	SetName
	Teo. Mexico 2006
*/
METHOD PROCEDURE SetName( name ) CLASS TField

	IF Empty( name ) .OR. !Empty( ::FName )
		RETURN
	ENDIF

	::FName := name

RETURN

/*
	SetPickList
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetPickList( pickList ) CLASS TField
	SWITCH ValType( pickList )
	CASE 'B'
		::FPickList := pickList
		EXIT
	CASE 'L'
		IF pickList
			::FPickList := .T.
		ENDIF
		EXIT
	END
RETURN

/*
	SetPrimaryKeyComponent
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetPrimaryKeyComponent( PrimaryKeyComponent ) CLASS TField
	LOCAL i

	SWITCH ::FFieldMethodType
	CASE 'A'
		FOR EACH i IN ::FFieldArrayIndex
			::FTable:FieldList[ i ]:PrimaryKeyComponent := PrimaryKeyComponent
		NEXT
		EXIT
	CASE 'C'
		::FPrimaryKeyComponent := PrimaryKeyComponent
	END

RETURN

/*
	SetUsingField
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetUsingField( usingField ) CLASS TField
	LOCAL AField := ::FTable:FieldByName( usingField )
	IF AField != NIL
		::FUsingField := AField
		::FCalculated := .T.
	ENDIF
RETURN

/*
	ENDCLASS TField
*/

/*
	TStringField
	Teo. Mexico 2006
*/
CLASS TStringField FROM TField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 0
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "C"
	DATA FSize
	DATA FType INIT "String"
	DATA FValType INIT "C"
	METHOD GetEmptyValue INLINE Space( ::Size )
	METHOD GetSize()
	METHOD SetBuffer( buffer )
	METHOD SetDefaultValue( DefaultValue )
	METHOD SetSize( size )
PUBLIC:
	METHOD GetAsString
PUBLISHED:
	PROPERTY Size READ GetSize WRITE SetSize
ENDCLASS

/*
	GetAsString
	Teo. Mexico 2009
*/
METHOD FUNCTION GetAsString CLASS TStringField
	LOCAL Result := ""
	LOCAL i

	SWITCH ::FFieldMethodType
	CASE 'A'
		FOR EACH i IN ::FFieldArrayIndex
			Result += ::FTable:FieldList[ i ]:AsString()
		NEXT
		EXIT
	OTHERWISE
		Result := ::GetAsVariant()
	ENDSWITCH

RETURN Result

/*
	GetSize
	Teo. Mexico 2010
*/
METHOD FUNCTION GetSize() CLASS TStringField
	LOCAL i

	IF ::FSize = NIL
		IF ::FFieldMethodType = "A"
			::FSize := 0
			FOR EACH i IN ::FFieldArrayIndex
				::FSize += ::FTable:FieldList[ i ]:Size
			NEXT
		ENDIF
	ENDIF

RETURN ::FSize

/*
	SetBuffer
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetBuffer( buffer ) CLASS TStringField
	IF ::IsDerivedFrom("TMemoField")
		Super:SetBuffer( buffer )
	ELSE
		Super:SetBuffer( PadR( buffer, ::Size ) )
	ENDIF
RETURN

/*
	SetDefaultValue
	Teo. Mexico 2006
*/
METHOD PROCEDURE SetDefaultValue( DefaultValue ) CLASS TStringField

	::FDefaultValue := DefaultValue
	
	::FBuffer := NIL /* to force ::Reset on next read */

RETURN

/*
	SetSize
	Teo. Mexico 2010
*/
METHOD PROCEDURE SetSize( size ) CLASS TStringField
	::FSize := size
	::DBS_LEN := size
RETURN

/*
	ENDCLASS TStringField
*/

/*
	TMemoField
	Teo. Mexico 2006
*/
CLASS TMemoField FROM TStringField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 4
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "M"
	DATA FSize INIT 0
	DATA FType INIT "Memo"
PUBLIC:
PUBLISHED:
ENDCLASS

/*
	ENDCLASS TMemoField
*/

/*
	TNumericField
	Teo. Mexico 2006
*/
CLASS TNumericField FROM TField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 0
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "N"
	DATA FType INIT "Numeric"
	DATA FValType INIT "N"
	METHOD GetEmptyValue BLOCK {|| 0 }
PUBLIC:

	METHOD GetAsString
	METHOD SetAsVariant( variant )

	PROPERTY AsNumeric READ GetAsVariant WRITE SetAsVariant

PUBLISHED:
ENDCLASS

/*
	GetAsString
	Teo. Mexico 2009
*/
METHOD FUNCTION GetAsString( Value ) CLASS TNumericField
	LOCAL Result

	IF Value == NIL
		Value := ::GetAsVariant()
	ENDIF

	IF ::OnGetText != NIL
		Result := Value
		::OnGetText:Eval( Self, @Result )
	ELSE
		Result := Str( Value )
	ENDIF

RETURN Result

/*
	SetAsVariant
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetAsVariant( variant ) CLASS TNumericField

	SWITCH ValType( variant )
	CASE 'C'
		Super:SetAsVariant( Val( variant ) )
		EXIT
	CASE 'N'
		Super:SetAsVariant( variant )
		EXIT
	END

RETURN

/*
	ENDCLASS TNumericField
*/

/*
	TIntegerField
	Teo. Mexico 2009
*/
CLASS TIntegerField FROM TNumericField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 4
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "I"
	DATA FType INIT "Integer"
PUBLIC:

	METHOD SetAsVariant( variant )

	PROPERTY AsInteger READ GetAsVariant WRITE SetAsVariant

PUBLISHED:
ENDCLASS

/*
	SetAsVariant
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetAsVariant( variant ) CLASS TIntegerField

	SWITCH ValType( variant )
	CASE 'C'
		Super:SetAsVariant( Int( Val( variant ) ) )
		EXIT
	CASE 'N'
		Super:SetAsVariant( Int( variant ) )
		EXIT
	END

RETURN

/*
	ENDCLASS TIntegerField
*/

/*
	TFloatField
	Teo. Mexico 2010
*/
CLASS TFloatField FROM TNumericField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 8
	DATA FDBS_DEC INIT 2
	DATA FDBS_TYPE INIT "B"
	DATA FType INIT "Float"
PUBLIC:
PUBLISHED:
ENDCLASS

/*
	ENDCLASS TFloatField
*/

/*
	TLogicalField
	Teo. Mexico 2006
*/
CLASS TLogicalField FROM TField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 1
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "L"
	DATA FType INIT "Logical"
	DATA FValType INIT "L"
	METHOD GetEmptyValue BLOCK {|| .F. }
PUBLIC:

	PROPERTY AsBoolean READ GetAsVariant WRITE SetAsVariant

PUBLISHED:
ENDCLASS

/*
	ENDCLASS TLogicalField
*/

/*
	TDateField
	Teo. Mexico 2006
*/
CLASS TDateField FROM TField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 4
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "D"
	DATA FDefaultValue INIT {|| Date() }
	DATA FSize INIT 8					// Size on index is 8 = len of DToS()
	DATA FType INIT "Date"
	DATA FValType INIT "D"
	METHOD GetEmptyValue BLOCK {|| CtoD("") }
PUBLIC:

	METHOD GetAsString INLINE FDateS( ::GetAsVariant() )
	METHOD SetAsVariant( variant )

	PROPERTY Size READ FSize

PUBLISHED:
ENDCLASS

/*
	SetAsVariant
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetAsVariant( variant ) CLASS TDateField

	SWITCH ValType( variant )
	CASE 'C'
		Super:SetAsVariant( AsDate( variant ) )
		EXIT
	CASE 'D'
		Super:SetAsVariant( variant )
		EXIT
	END

RETURN

/*
	ENDCLASS TDateField
*/

/*
	TDateTimeField
	Teo. Mexico 2009
*/
CLASS TDateTimeField FROM TField
PRIVATE:
PROTECTED:
	DATA FSize INIT 23
	DATA FDBS_LEN INIT 8
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "@"
	DATA FDefaultValue INIT {|| HB_DateTime() }
	DATA FType INIT "DateTime"
	DATA FValType INIT "C"
	METHOD GetEmptyValue BLOCK {|| HB_DateTime( CToD("") ) }
PUBLIC:

    CLASSDATA fmtDate INIT "YYYY-MM-DD"
    CLASSDATA fmtTime

    METHOD SetAsVariant( variant )

	PROPERTY Size READ FSize

PUBLISHED:
ENDCLASS

/*
	SetAsVariant
	Teo. Mexico 2009
*/
METHOD PROCEDURE SetAsVariant( variant ) CLASS TDateTimeField

	SWITCH ValType( variant )
    CASE 'T'
        Super:SetAsVariant( variant )
        EXIT
	CASE 'C'
        variant := RTrim( variant )
        IF NumToken( variant ) > 1
            variant := HB_CToT( variant, ::fmtDate, ::fmtTime )
        ELSE
            variant := HB_SToT( variant )
        ENDIF
		Super:SetAsVariant( variant )
		EXIT
	CASE 'D'
		Super:SetAsVariant( HB_DateTime( variant ) )
		EXIT
    CASE 'N'
        Super:SetAsVariant( HB_NToT( variant ) )
        EXIT
	ENDSWITCH

RETURN

/*
	EndClass TDateTimeField
*/


/*
	TModTimeField
	Teo. Mexico 2009
*/
CLASS TModTimeField FROM TDateTimeField
PRIVATE:
PROTECTED:
	DATA FDBS_LEN INIT 8
	DATA FDBS_DEC INIT 0
	DATA FDBS_TYPE INIT "="
	DATA FType INIT "ModTime"
PUBLIC:
PUBLISHED:
ENDCLASS

/*
	EndClass TModTimeField
*/

/*
	TObjectField
	Teo. Mexico 2009
*/
CLASS TObjectField FROM TField
PRIVATE:
	DATA FObjType
	DATA FLinkedTable									 /* holds the Table object */
	DATA FLinkedTableMasterSource
	METHOD GetSize INLINE ::GetReferenceField():Size
	METHOD SetLinkedTableMasterSource( linkedTableMasterSource ) INLINE ::FLinkedTableMasterSource := linkedTableMasterSource
	METHOD SetObjType( objValue ) INLINE ::FObjType := objValue
PROTECTED:
	DATA FCalcMethod
	DATA FType INIT "ObjectField"
	DATA FValType INIT "O"
    METHOD GetDBS_LEN INLINE ::GetReferenceField():DBS_LEN
    METHOD GetDBS_TYPE INLINE ::GetReferenceField():DBS_TYPE
	METHOD GetLinkedTable
	METHOD GetEmptyValue() INLINE ::LinkedTable:GetPrimaryKeyField():EmptyValue
	METHOD GetFieldReadBlock()
PUBLIC:
	METHOD DataObj
	METHOD GetKeyVal( keyVal )
	METHOD GetAsString							//INLINE ::LinkedTable:GetPrimaryKeyField():AsString()
	METHOD GetAsVariant( ... )
	METHOD GetReferenceField()	// Returns the non-TObjectField associated to this obj
	PROPERTY LinkedTable READ GetLinkedTable
	PROPERTY LinkedTableMasterSource READ FLinkedTableMasterSource WRITE SetLinkedTableMasterSource
	PROPERTY ObjType READ FObjType WRITE SetObjType
	PROPERTY Size READ GetSize
PUBLISHED:
ENDCLASS

/*
	GetKeyVal
	Teo. Mexico 2009
*/
METHOD FUNCTION GetKeyVal( keyVal ) CLASS TObjectField
	LOCAL pkField
	
	keyVal := Super:GetKeyVal( keyVal )

	pkField := ::GetReferenceField()
	
	IF pkField = NIL
		RETURN keyVal
	ENDIF

RETURN pkField:GetKeyVal( keyVal )

/*
	DataObj
	Syncs the Table with the key in buffer
	Teo. Mexico 2009
*/
METHOD FUNCTION DataObj CLASS TObjectField
	LOCAL linkedTable
	LOCAL linkedObjField
	LOCAL keyVal

	IF ::FCalculated
		RETURN ::FieldReadBlock:Eval( ::FTable )
	ENDIF

	linkedTable := ::LinkedTable

	IF ::IsMasterFieldComponent .AND. ::FTable:FUnderReset

	ELSE
		keyVal := ::GetAsVariant()
		/* Syncs with the current value */
		IF !::FTable:MasterSource == linkedTable .AND. !linkedTable:PrimaryIndex:KeyVal == keyVal
			linkedObjField := linkedTable:LinkedObjField
			linkedTable:LinkedObjField := NIL
			linkedTable:PrimaryIndex:SetKeyVal( keyVal )
			linkedTable:LinkedObjField := linkedObjField
		ENDIF
	ENDIF

RETURN linkedTable

/*
	GetAsString
	Teo. Mexico 2009
*/
METHOD FUNCTION GetAsString CLASS TObjectField
	LOCAL Result

	Result := ::GetBuffer()

RETURN Result

/*
	GetAsVariant
	Teo. Mexico 2010
*/
METHOD FUNCTION GetAsVariant( ... ) CLASS TObjectField
	LOCAL variant
	
	variant := Super:GetAsVariant( ... )
	
	IF HB_IsObject( variant )

		IF variant:IsDerivedFrom("TObjectField")
			RETURN variant:DataObj:GetKeyVal()
		ELSEIF variant:IsDerivedFrom("TTable")
			RETURN variant:GetKeyVal()
		ENDIF
	ENDIF

RETURN variant

/*
	GetFieldReadBlock
	Teo. Mexico 2010
*/
METHOD FUNCTION GetFieldReadBlock() CLASS TObjectField

	IF ::FFieldReadBlock = NIL .AND. Super:GetFieldReadBlock() = NIL
		::FFieldReadBlock := {|| ::LinkedTable }
	ENDIF

RETURN ::FFieldReadBlock

/*
	GetLinkedTable
	Teo. Mexico 2009
*/
METHOD FUNCTION GetLinkedTable CLASS TObjectField
	LOCAL linkedTableMasterSource

	IF ::FLinkedTable == NIL

		IF Empty( ::FObjType )
			RAISE TFIELD ::Name ERROR "TObjectField has not a ObjType value."
		ENDIF

		/*
		 * Solve using the default ObjType
		 */
		SWITCH ValType( ::FObjType )
		CASE 'C'
			IF ::FTable:MasterSource != NIL .AND. ::FTable:MasterSource:IsDerivedFrom( ::FObjType ) .AND. ::IsMasterFieldComponent
				::FLinkedTable := ::FTable:MasterSource
			ELSE
				IF ::FLinkedTableMasterSource != NIL
					linkedTableMasterSource := ::FLinkedTableMasterSource:Eval( ::FTable )
				ELSEIF ::FTable:IsDerivedFrom( ::Table:GetMasterSourceClassName( ::FObjType ) )
					linkedTableMasterSource := ::FTable
				ENDIF
				::FLinkedTable := __ClsInstFromName( ::FObjType )
				IF ::FLinkedTable:IsDerivedFrom( ::FTable:ClassName() )
					RAISE TFIELD ::Name ERROR "Denied: To create TObjectField's linked table derived from the same field's table class."
				ENDIF
				::FLinkedTable:New( linkedTableMasterSource )
			ENDIF
			EXIT
		CASE 'B'
			::FLinkedTable := ::FObjType:Eval( ::FTable )
			EXIT
		CASE 'O'
			::FLinkedTable := ::FObjType
			EXIT
		ENDSWITCH

		IF !HB_IsObject( ::FLinkedTable ) .OR. ! ::FLinkedTable:IsDerivedFrom( "TTable" )
			RAISE TFIELD ::Name ERROR "Default value is not a TTable object."
		ENDIF
		
		/*
		 * Attach the current DataObj to the one in table to sync when table changes
		 * MasterFieldComponents are ignored, a child cannot change his parent :)
		 */
		IF !::IsMasterFieldComponent .AND. ::FLinkedTable:LinkedObjField == NIL
			/*
			 * LinkedObjField is linked to the FIRST TObjectField were it is referenced
			 * this has to be the most top level MasterSource table
			 */
			::FLinkedTable:LinkedObjField := Self
		ELSE
			/*
			 * We need to set this field as READONLY, because their LinkedTable
			 * belongs to a some TObjectField in some MasterSource table
			 * so this TObjectField cannot modify the physical database here
			 */
			//::ReadOnly := .T.
		ENDIF

	ENDIF

RETURN ::FLinkedTable

/*
	GetReferenceField
	Teo. Mexico 2010
*/
METHOD FUNCTION GetReferenceField() CLASS TObjectField
	LOCAL pkField
	LOCAL masterSourceClassName := ::FTable:GetMasterSourceClassName()

	IF ::IsMasterFieldComponent .AND. !Empty( masterSourceClassName ) .AND. ::DataObj:IsDerivedFrom( masterSourceClassName )
		pkField := ::DataObj:GetPrimaryKeyField( masterSourceClassName )
	ELSE
//		pkField := ::DataObj:GetPrimaryKeyField( ::DataObj:GetMasterSourceClassName() )
		pkField := ::DataObj:GetPrimaryKeyField()
	ENDIF

RETURN pkField

/*
	ENDCLASS TObjectField
*/
