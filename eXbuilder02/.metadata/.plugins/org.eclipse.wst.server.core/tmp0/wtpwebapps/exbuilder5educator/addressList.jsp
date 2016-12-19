<%@page import="example.db.DB"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%><%@ page import="java.sql.*" %><%@ page import="com.tomato.xml.*" %>
<%

/***************************************************************************
* Set the character encoding to utf-8
***************************************************************************/
request.setCharacterEncoding("utf-8");
/**************************************************************************
* Gain parameter received from client ("Name" searching conditon of Search Part)
**************************************************************************/
String strSearchName = (String)request.getParameter("searchName");

/**************************************************************************
* Database variable declaration
**************************************************************************/
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;

/**************************************************************************
* XML Document(XML Conversion document) Creation
**************************************************************************/
com.tomato.xml.XTMDocument doc = new XTMDocument();


    /**************************************************************************
    * sample.db Connect 
    **************************************************************************/
    DB db = DB.getInstance();
    conn = db.getConnection("sample");
        String[][] a = {{"seq","INTEGER PRIMARY KEY AUTOINCREMENT"},{"name","NVARCHAR(50)"},{"zipcode","NVARCHAR(20)"},{"address","NVARCHAR(255)"},{"officetel","NVARCHAR(30)"},{"hptel","NVARCHAR(30)"}};
        db.createTable("sample","address", a);
    try {	
    /**************************************************************************
    * Query Creation
    **************************************************************************/
    StringBuffer strBuffer = new StringBuffer();

    strBuffer.append("SELECT seq                ")
             .append("     , name               ")
             .append("     , zipcode            ")
             .append("     , address            ")
             .append("     , officetel          ")
             .append("     , hptel              ")
             .append("  FROM address            ");

    if(strSearchName != null && !"".equals(strSearchName))
        strBuffer.append(" WHERE name like '%").append(strSearchName).append("%'");

    /**************************************************************************
    * Get ResultSet
    **************************************************************************/
    stmt= conn.createStatement();
    rs = stmt.executeQuery(strBuffer.toString());
    /******************************************************
    ********************
    * Repeat Node Creation
    * <addressList>
    *   <list>
    *      <seq>Value 1</seq>
    *      <name>Value 2</name>
    *      <zipcode>Value 3</zipcode>
    *      <address>Value 4</address>
    *      <officetel>Value 5</officetel>
    *      <hptel>Value 6</hptel>
    *   </list>
    * </addressList>
    **************************************************************************/
    com.tomato.xml.Repeater    rpt = new Repeater("addressList","","list");	

    /**************************************************************************
    * Put XML Document after putting ResultSet on Repeater
    **************************************************************************/
    rpt.store(rs);	
    doc.appendChild((Repeater)rpt); 	    
            
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
