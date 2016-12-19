<%@page import="example.db.DB"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%><%@ page import="java.sql.*" %><%@ page import="com.tomato.xml.*" %>
<%

/***************************************************************************
* Set the character encoding to utf-8
***************************************************************************/
request.setCharacterEncoding("utf-8");
/**************************************************************************
* Get parameter received from client
**************************************************************************/
String strName      = (String)request.getParameter("name");
String strZipCode   = (String)request.getParameter("zipcode");
String strAddress   = (String)request.getParameter("address");
String strOfficeTel = (String)request.getParameter("officetel");
String strHpTel     = (String)request.getParameter("hptel");

/**************************************************************************
* Parameter NULL Check && generation Quatation
**************************************************************************/
if(strName == null)      strName      = ""; 
if(strZipCode == null)   strZipCode   = "";
if(strAddress == null)   strAddress   = ""; 
if(strOfficeTel == null) strOfficeTel = ""; 
if(strHpTel == null)     strHpTel     = ""; 

/**************************************************************************
* Database variable declaration
**************************************************************************/
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

/**************************************************************************
* XML Document(XMLConversion Document) Creation
**************************************************************************/
com.tomato.xml.XTMDocument doc = new XTMDocument();

try {
    /**************************************************************************
    * Connect to address.mdb 
    **************************************************************************/
    DB db = DB.getInstance();
    conn = db.getConnection("sample");

    /**************************************************************************
    * Query Creation
    **************************************************************************/
    StringBuffer strBuffer = new StringBuffer();

    strBuffer.append("INSERT INTO address(             ")
             .append("       name               ")
             .append("     , zipcode            ")
             .append("     , address            ")
             .append("     , officetel         ")
             .append("     , hptel             ")
             .append(") VALUES (            ")
             .append("       ").append("?")
             .append("     , ").append("?")
             .append("     , ").append("?")
             .append("     , ").append("?")
             .append("     , ").append("?")
             .append(" )  ");
    /**************************************************************************
    * Get ResultSet
    **************************************************************************/
    PreparedStatement psmt = conn.prepareStatement(strBuffer.toString());
    psmt.setString(1, strName);
    psmt.setString(2, strZipCode);
    psmt.setString(3, strAddress);
    psmt.setString(4, strOfficeTel);
    psmt.setString(5, strHpTel);
    int intCount = 0;
    //intCount = stmt.executeUpdate(strBuffer.toString());
    intCount = psmt.executeUpdate();

    if(intCount != 1){
        doc.setAttribute("message","Error occurs in inserting");
        doc.setAttribute( "replace","false" );
    }
        
} catch(Exception e){
    e.printStackTrace();
    doc.setAttribute("message",e.toString());
    doc.setAttribute("replace","false" );
} finally {
    /**************************************************************************
    * Garbage Collection
    **************************************************************************/
    if(rs != null) rs.close();
    if(stmt != null) stmt.close();
    if(conn != null) conn.close();
    /**************************************************************************
    * Write XML document on JSP
    **************************************************************************/
    out.print(doc.toString());
}
%>

