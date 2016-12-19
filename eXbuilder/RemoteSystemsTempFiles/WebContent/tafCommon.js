/*******************************************************************************
* fRepeatSort : Support sort of related Repeat.
* parameter : (string)strRptNm – Repeat control ID
* parameter : (string)strSortNodeName
* - Node name of nodeset of Control inside Repeat that you want to sort
* - (include Repeat Ref)
* parameter : (string)strSortType - text: character, number : digit
* parameter : (boolean)blnSortOrder - true:ascending order,false:descending order
* return : void
********************************************************************************/
function fRepeatSort(strRptNm, strSortNodeName, strSortType, blnSortOrder)
{
	// Create Repeat Control Object
	var rptObject = model.getControl(strRptNm);
	// in the case that object is null, return
	if( rptObject == null ) return;
	// delete related Repeat Control sort
	rptObject.sortRemoveAll();
	// Save sorting type of related Repeat Control
	rptObject.setSort(strSortNodeName, strSortType, blnSortOrder);
	// Sort related Repeat Control
	rptObject.sort();
	// Renew related Repeat Control
	model.refreshControl(strRptNm);
}   