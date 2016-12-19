<%@ page language="java" contentType="text/html; charset=euc-kr"%><%@ page import="java.sql.*" %><%@ page import="com.tomato.xml.*" %>
<%

/***************************************************************************
* Set the character encoding to utf-8
***************************************************************************/
request.setCharacterEncoding("utf-8");
/**************************************************************************
* Get parameter received from client
**************************************************************************/
String strSeq       = (String)request.getParameter("seq");
String strName      = (String)request.getParameter("name");
String strZipCode   = (String)request.getParameter("zipcode");
String strAddress   = (String)request.getParameter("address");
String strOfficeTel = (String)request.getParameter("officetel");
String strHpTel     = (String)request.getParameter("hptel");

/**************************************************************************
* Parameter NULL Check && generation Quatation
**************************************************************************/
if(strSeq == null)       strSeq       = "";   else strSeq       = "" + strSeq + "";

/**************************************************************************
* Database variable declaratoin
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
    * sample.db Connect 
    **************************************************************************/
    Class.forName("org.sqlite.JDBC");
    conn = DriverManager.getConnection("jdbc:sqlite:sample.db");

    /**************************************************************************
    * Query Creation
    **************************************************************************/
    StringBuffer strBuffer = new StringBuffer();

    strBuffer.append("DELETE FROM address        ")
             .append(" WHERE seq         =       ").append(strSeq);
    /**************************************************************************
    * Get ResultSet
    **************************************************************************/
    stmt= conn.createStatement();
    int intCount = 0;
    intCount = stmt.executeUpdate(strBuffer.toString());

    if(intCount != 1){
        doc.setAttribute("message","An error has occurred when deleting.");
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

