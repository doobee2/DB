package test;

import dao.DBC;
import dao.MariaDBCon;
import dto.Member;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DaoTest1 {
    static Connection conn = null;
    static PreparedStatement pstmt = null;
    static ResultSet rs = null;

    public static void main(String[] args) {
        DBC con = new MariaDBCon();
        conn = con.connect();

            System.out.println("DB 연결 성공");

        String sql = "select * from member";
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            List<Member> memList = new ArrayList<>();
            while (rs.next()){
                Member mem = new Member();
                mem.setId(rs.getString("id"));
                mem.setPw(rs.getString("pw"));
                mem.setName(rs.getString("name"));
                mem.setEmail(rs.getString("email"));
                mem.setTel(rs.getString("tel"));
                mem.setRegdate(rs.getString("regdate"));
                mem.setPoint(rs.getInt("point"));
                memList.add(mem);
            }
            for(Member m : memList) {
                System.out.println(m.toString());
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        } finally {
            con.close(rs, pstmt, conn);
        }
    }
}
