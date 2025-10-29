package com.tjg_project.candy.domain.user.repository;

import com.tjg_project.candy.domain.user.entity.Users;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import javax.sql.DataSource;

@Repository
public class JdbcTemplateUsersRepository implements UsersRepository{
    private final JdbcTemplate jdbcTemplate;

    public JdbcTemplateUsersRepository (DataSource dataSource) {
        this.jdbcTemplate = new JdbcTemplate(dataSource);
    }

    @Override
    public boolean signup(Users users) {
        String sql = "insert into users(birthday, email, gender, name, password, phone, provider, user_id) values(?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] param = {
                users.getBirthday(), users.getEmail(), users.getGender(), users.getName(), users.getPassword(),
                users.getPhone(), users.getProvider(), users.getUserId()
        };

        int rows = jdbcTemplate.update(sql, param);
        return false;
    }
}
