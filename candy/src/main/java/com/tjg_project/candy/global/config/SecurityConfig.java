//package com.tjg_project.candy.global.config;
//
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//
//@Configuration
//public class SecurityConfig {
//
//
//    private final JwtFilter jwtFilter;
//    private final CustomOAuth2SuccessHandler customOAuth2SuccessHandler;
//
//    public SecurityConfig(JwtFilter jwtFilter, CustomOAuth2SuccessHandler customOAuth2SuccessHandler) {
//        this.jwtFilter = jwtFilter;
//        this.customOAuth2SuccessHandler = customOAuth2SuccessHandler; // ✅ 주입
//    }
//
//    @Bean
//    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
//        return http
//                .csrf(crsf -> crsf.disable())
//                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
//                .formLogin(form -> form.disable())   // ✅ 기본 폼 로그인 끄기
//                .httpBasic(basic -> basic.disable())
////                .sessionManagement(session -> session.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
//                .authorizeHttpRequests(auth -> auth.requestMatchers("/api/**", "/api/register/**", "/api/reservations/**", "/api/upload/analyze", "/api/results", "/api/gpt/**", "/login/**", "/oauth2/**","/api/uploadImage", "/api/pay/**").permitAll().anyRequest().authenticated())
//                .oauth2Login(oauth -> oauth     // ✅ OAuth2 로그인 활성화
//                        .successHandler(customOAuth2SuccessHandler)// 로그인 성공 후 리다이렉트 URL
//                )
//                .addFilterBefore(jwtFilter, UsernamePasswordAuthenticationFilter.class)
//                .build();
//
//    }
//
//
//    // ✅ CORS 허용 설정
//    @Bean
//    public CorsConfigurationSource corsConfigurationSource() {
//        CorsConfiguration configuration = new CorsConfiguration();
//        configuration.setAllowedOrigins(List.of("http://localhost:3000","http://127.0.0.1:3000")); // 프론트 도메인
//        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
//        configuration.setAllowedHeaders(List.of("*"));
//        configuration.setAllowCredentials(true); // 쿠키/헤더 인증 허용
//
//        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
//        source.registerCorsConfiguration("/**", configuration);
//        return source;
//    }
//
//
//}