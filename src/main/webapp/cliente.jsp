<%-- 
    Document   : cliente
    Created on : 16/09/2015, 16:54:05
    Author     : Tiago Neres da Silva
--%>

<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SysPWD - Cliente</title>
    </head>
    <body>
    <form action="cliente.jsp" method="post">    
    <%
        //dados para conexão com o banco
        String databaseURL = "jdbc:postgresql://localhost:5432/Paripassu";
        String usuario = "postgres";
        String senha = "098!@#01";
        String driverName = "org.postgresql.Driver";
        
        //inicialização de variáveis
        int senhan = 0;
        int senhap = 0;
        int resultado = 0;
    
        try {
            //conexão do banco
            Class.forName(driverName).newInstance();
            Connection conn = DriverManager.getConnection(databaseURL, usuario, senha);
            System.out.println("Conexão obtida com sucesso.");
            
            //receber valores de senhas normais
            PreparedStatement pStmt = conn.prepareStatement("Select senha from normal where id = (Select max(id) from normal) and status is null");
            ResultSet rs = pStmt.executeQuery();
            while (rs.next()){
            senhan = rs.getInt("senha");
            %>
                <input type="radio" name="tipo" value="Normal" checked="checked">Normal
                <input type="text" name="senha" value="N<%=senhan%>">
            <%
            }
            if (senhan == 0){
            %>
                <input type="radio" name="tipo" value="Normal" checked="checked">Normal
                <input type="text" name="senha" value="N<%=senhan%>">
            <%    
            }            
            rs.close();
            pStmt.close();
            
            //receber valores de senhas preferenciais
            PreparedStatement pStmt1 = conn.prepareStatement("Select senha from preferencial where id = (Select max(id) from preferencial) and status is null");
            ResultSet rs1 = pStmt1.executeQuery();
            while (rs1.next()){
            senhap = rs1.getInt("senha");

            %>
                <input type="radio" name="tipo" value="Preferencial">Preferencial
                <input type="text" name="senha" value="P<%=senhap%>">
            <%
            }
            if (senhap == 0){
            %>
                <input type="radio" name="tipo" value="Preferencial">Preferencial
                <input type="text" name="senha" value="P<%=senhap%>">
            <%    
            }
            rs1.close();
            pStmt1.close();
            
            //receber o valor do radio button
            String tipo=request.getParameter("tipo");
            
            //comparar o valor do radio button
            if (tipo.equals("Normal")){
                //System.out.println("Normal");
                senhan = senhan + 1;
                 
                PreparedStatement pStmt2 = conn.prepareStatement("Insert into normal (senha) values ("+senhan+")");
                pStmt2.executeUpdate();
                pStmt2.close();
            }
            else{
                //System.out.println("???");
                senhap = senhap + 1;
                
                PreparedStatement pStmt3 = conn.prepareStatement("Insert into preferencial (senha) values ("+senhap+")");
                pStmt3.executeUpdate();
                pStmt3.close();                
            }
            
            //encerrar a conexão com o banco de dados
            conn.close();
            //atualizar a pagina para mostrar a senha atual gerada
            response.addHeader("Refresh","0");
            }
        //mensagens para tratar erros de transação
        catch (SQLException ex) {
            System.out.println("SQLException: " + ex.getMessage());
            System.out.println("SQLState: " + ex.getSQLState());
            System.out.println("VendorError: " + ex.getErrorCode());
            }
        //mensagen para tratar erro de conexão
        catch (Exception e) {
            System.out.println("Problemas ao tentar conectar com o banco de dados: " + e);
            //System.out.println(System.getProperty("java.class.path"));
            }      
    %>
    <input type="submit" name="btn_enviar" value="Gerar">    
</form>
    </body>
</html>
