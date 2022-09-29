package util;

import java.sql.Connection;
import java.sql.DriverManager;

//db¿¬µ¿
public class DatabaseUtil {
	public static Connection getConnection() {
		try {
			String dbURL = "jdbc:mariadb://localhost:3306/LectureEvaluation";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("org.mariadb.jdbc.Driver");
			return DriverManager.getConnection(dbURL, dbID, dbPassword);
		}catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
