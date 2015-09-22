<%-- 
    Document   : gerente
    Created on : 16/09/2015, 16:51:19
    Author     : Tiago Neres da Silva
--%>

<%@page import="java.io.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SysPWD - Gerente</title>
    </head>
    <body>
        <h1>Gerencie a fila</h1>
        <form action="gerente.jsp" method="post">
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
            PreparedStatement pStmt = conn.prepareStatement("Select id, senha from normal where status is null order by senha DESC");
            ResultSet rs = pStmt.executeQuery();
            while (rs.next()){
            //idn = rs.getInt("id");
            senhan = rs.getInt("senha");    
            }
            rs.close();
            pStmt.close();
            
            //receber valores de senhas preferenciais
            PreparedStatement pStmt1 = conn.prepareStatement("Select id, senha from preferencial where status is null order by senha DESC");
            ResultSet rs1 = pStmt1.executeQuery();
            while (rs1.next()){
            //idp = rs.getInt("id");
            senhap = rs1.getInt("senha");    
            }
            rs1.close();
            pStmt1.close();

            //comparar o valor do radio button
            if (senhap != 0){
                //se prioridade diferente de 0 chama ela e depois aplica status de chamado e atualiza monitor
                %>
                <input type="text" name="senha" value="P<%=senhap%>">
                <%
                String senhapx = "";
                senhapx = "P" + senhap;
                //passar o valor da variável para outra página
                session.setAttribute("senhapx", senhapx); 
       
                String acao = request.getParameter("btn_proximo");
                if (acao.equals("Proximo")){
                    if (request.getParameter("btn_proximo").equals("Proximo")){
                    PreparedStatement pStmt2 = conn.prepareStatement("Update preferencial set status = 'x' where senha = "+senhap+"");
                    pStmt2.executeUpdate();
                    pStmt2.close();
                    }
                }
            }
            else{
                %>
                <input type="text" name="senha" value="N<%=senhan%>">
                <%
                String senhapx = "";
                senhapx = "N" + senhan;
                //passar o valor da variável para outra página
                session.setAttribute("senhapx", senhapx);
            
                String acao = request.getParameter("btn_proximo");
                if (acao.equals("Proximo")){
                    if (request.getParameter("btn_proximo").equals("Proximo")){
                        PreparedStatement pStmt3 = conn.prepareStatement("Update normal set status = 'x' where senha = "+senhan+"");
                        pStmt3.executeUpdate();
                        pStmt3.close();
                    }
                }
            }
            //codigo do botao para zerar as senhas
            String acao1 = request.getParameter("rd_zerar");
            if (acao1.equals("Zerar")){
                if (request.getParameter("rd_zerar").equals("Zerar")){
                PreparedStatement pStmt4 = conn.prepareStatement("Delete from normal");
                pStmt4.executeUpdate();
                pStmt4.close();
                
                PreparedStatement pStmt5 = conn.prepareStatement("Delete from preferencial");
                pStmt5.executeUpdate();
                pStmt5.close();
                }
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
        <input type="submit" name="btn_proximo" value="Proximo"><br><br>
        <!--<input type="button" name="btn_zerar" value="Zerar">-->
        <input type="radio" name="rd_zerar" value="Zerar">Para zerar o contador selecione aqui e clique em próximo
        </form>
    </body>
</html>
