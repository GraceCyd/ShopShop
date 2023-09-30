const mysql = require("mysql");

module.exports = {
    checkPassword: async (pool, authenSignature) => {
        let sql = "SELECT a.user_id, a.user_name, a.name,"
                    +"a.email, a.role_id, b.role_name "
                    +"FROM users a JOIN roles b ON a.role_id = b.role_id "
                    +"WHERE MD5(CONCAT(user_name, '&', password)) = ?";

        sql = mysql.format(sql, [authenSignature]);

        return await pool.query(sql);
    },

    // สมัครสมาชิก
    createUser: async (pool, nameUser, roleId, email, address, tel, userName, password) => {
      var sql = "INSERT INTO users (name, role_id, email, address, tel, user_name, password) "
                  + "VALUES (?, 3, ?, ?, ?, ?, ?)";

          sql = mysql.format(sql, [nameUser, roleId, email, address, tel, userName, password]);

          return await pool.query(sql);
  },

  getByUserId: async (pool, UserId) => {
      var sql = "SELECT u.*, r.role_name FROM "
                  + "Users u "
                  + "JOIN roles r ON u.role_id = r.role_id "
                  + "WHERE u.User_id = ?";
  
      sql = mysql.format(sql, [UserId]);
      
      return await pool.query(sql);
  },
    
    
}