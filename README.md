
첨부된 SpringRestApiBoardDBDDL.sql, SpringRestApiBoardDBDML.sql 쿼리문을 순서대로 입력

프로젝트 내부 webapp/WEB-INF/config/foot-context.xml
dataSource 부분을 환경에 맞춰서 포트 및 테이블 명, 아이디 및 비밀번호 변경
	<bean id="dataSource" class="org.apache.commons.dbcp2.BasicDataSource">
	    <property name="driverClassName" value="org.mariadb.jdbc.Driver" />
	    <property name="url" value="jdbc:mariadb://localhost:####/board_table" /> 
	    <property name="username" value="####" /> 
	    <property name="password" value="####" />
	</bean>

테이블 명을 변경하였을 경우 /resources/mapper 경로의 boardMapper.xml와 commentMapper.xml의 테이블 명 부분 변경 필요
