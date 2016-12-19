package example.db;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {

    private static DB INSTANCE = null;

    private DB() {

    }

    /**
     * DB객체를 얻습니다.
     * @return
     */
    public static DB getInstance() {
        if (INSTANCE == null) {
            INSTANCE = new DB();
        }
        return INSTANCE;
    }

    /**
     * DB에 연결합니다.
     * @return Connection
     */
    public Connection getConnection(String dbname) {
        Connection conn = null;
        File file = new File("");
        String path = file.getAbsolutePath();
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:"+path+"\\"+dbname+".db");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return conn;
    }

    /**
     * DB에 테이블이 있는지 여부를 반환합니다.
     * @param tableName
     * @return
     */
    public boolean hasTable(String dbname,String tableName) {
        Connection conn = getConnection(dbname);
        Statement stmt = null;
        ResultSet rs = null;
        
        try {
            stmt = conn.createStatement();
            rs = stmt.executeQuery("SELECT * FROM " + tableName + ";");

        } catch (SQLException e) {
            return false;
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
            }
        }
        return true;
    }

    /**
     * DB에 테이블을 생성합니다.
     * @param name
     * @param list
     */
    public void createTable(String dbname, String name, String[][] list) {

        String sql = "CREATE TABLE IF NOT EXISTS [" + name + "] (";
        
        for (int i = 0; i < list.length; i++) {
            if (list.length - 1 == i) {
                sql += "[" + list[i][0] + "] " + list[i][1];
            } else {
                sql += "[" + list[i][0] + "] " + list[i][1] + ",";
            }
        }
        sql += ");";

        Connection conn = getConnection(dbname);
        Statement stmt = null;
        try {
            stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            stmt.close();
            conn.close();
            stmt = null;
            conn = null;            		

        } catch (SQLException e) {
            System.out.println("table already exists");
        } finally {
            try {
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * 테스트
     * @param args
     */
    public static void main(String[] args) {
        DB db = new DB();
        Connection conn = db.getConnection("sample");
        Statement stmt;
        try {
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM ADDRESS;");
            while (rs.next()) {
                System.out.println(rs.getString(2));
            }
            rs.close();
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
