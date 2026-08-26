# 🚀 Comércio SaaS - Framework White-Label de Catálogo & Automação de Pedidos

Framework completo e modular para criação e venda de plataformas de cardápio digital, catálogo de produtos e automação de pedidos via WhatsApp com painel administrativo em tempo real.

---

## 🌟 Funcionalidades Principais

### 1. 📱 Cardápio & Catálogo Digital do Cliente (`index.html`)
- Suporte a qualquer nicho de mercado (*Marmitarias, Pizzarias, Hamburguerias, Distribuidoras, Açaí, Mercados, Lojas em Geral*).
- Variações de tamanhos e preços (**P, M e G** / **Broto, Média e Grande** / **300ml, 500ml, 700ml**).
- Seleção de adicionais e observações personalizadas.
- Carrinho dinâmico com cálculo de taxa de entrega e chave Pix instantânea.
- Envio formatado em 1 clique direto para o WhatsApp do lojista.

### 2. 💻 Painel Administrativo do Lojista (`dashboard.html`)
- **Gestão de Pedidos em Tempo Real**: Alertas sonoros, badges de status (*Pendente, Em Preparo, Saiu para Entrega, Finalizado, Cancelado*).
- **Impressão Térmica Automática**: Layout compacto padrão de 80mm e 58mm para cozinhas e motoboys.
- **Gestão de Produtos**:
  - Cadastro rápido com fotos (compressão automática direto no navegador).
  - Controle de disponibilidade granular por tamanho (ex: pausar tamanho P mantendo M ativo).
  - Organização por categorias e ordenação.
- **Horários & Automação**:
  - Modo Automático (abre e fecha conforme os horários definidos).
  - Forçar loja aberta ou fechada com mensagem de aviso personalizada.
- **Integração WhatsApp Evolution API**: Pareamento via QR Code / Código de 8 dígitos para disparo automatizado de status.

### 3. ⚡ Onboarding & Criação Instantânea de Lojas (`criar-loja.html`)
- Permite que qualquer comerciante crie sua loja em menos de **2 minutos**.
- Geração automática de slug/URL exclusivo (`?loja=minha-loja`).
- Injeção de catálogo template pronto conforme o nicho escolhido.
- Entrega imediata dos links de cardápio e painel.

---

## 🛠️ Stack Tecnológica

- **Frontend**: HTML5, Tailwind CSS, Lucide Icons, Vanilla JavaScript.
- **Backend / Database**: Supabase (PostgreSQL, Row Level Security, Realtime Pub/Sub).
- **Deploy**: Netlify / Vercel / GitHub Pages / Servidor Próprio com Nginx.

---

## 🚀 Como Rodar e Publicar

1. **Executar o Schema no Supabase**:
   - Copie o conteúdo de `supabase_schema.sql` e execute no SQL Editor do seu projeto Supabase.

2. **Deploy no Netlify / Vercel**:
   - Conecte este repositório no Netlify ou faça o upload da pasta.
   - O arquivo `netlify.toml` já contém todas as rotas limpas configuradas (`/criar-loja`, `/dashboard`).
