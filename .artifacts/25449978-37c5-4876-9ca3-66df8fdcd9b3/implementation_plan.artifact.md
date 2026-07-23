# Ignorar Arquivos e Diretórios Particulares (Dotfiles)

O objetivo é atualizar o arquivo `.gitignore` para garantir que todos os arquivos e diretórios que começam com ponto (`.`) sejam ignorados pelo Git, tornando-os particulares e evitando que sejam incluídos nos commits.

## User Review Required

> [!IMPORTANT]
> Adicionarei o padrão `.*` ao `.gitignore`. Para evitar que o próprio arquivo `.gitignore` e outros arquivos de configuração essenciais do Flutter (como `.metadata`) sejam ignorados acidentalmente, utilizarei exceções (`!`).
>
> Arquivos que **continuarão** sendo rastreados:
> - `.gitignore`
> - `.metadata` (necessário para o Flutter saber a versão/tipo do projeto)

## Mudanças Propostas

### Git Configuration

#### [MODIFY] [.gitignore](file:///home/rtadeu/Dev/FlutterProject/dia_a_dia/.gitignore)
- Adicionar uma nova seção no início do arquivo para ignorar dotfiles:
```gitignore
# Private dotfiles and directories
.*
!.gitignore
!.metadata
```

## Plano de Verificação

### Verificação Manual
- Executar `git check-ignore -v .artifacts` para confirmar que o diretório está sendo ignorado.
- Executar `git check-ignore -v .senhaSB.txt` para confirmar que o arquivo está sendo ignorado.
- Garantir que `git check-ignore -v .gitignore` retorne que o arquivo **não** está sendo ignorado.
