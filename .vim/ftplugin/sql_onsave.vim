:autocmd! BufWritePre <buffer> :% ! python -c 'import sys; import sqlparse; print(sqlparse.format("".join(sys.stdin), reindent=True, keyword_case="upper"))'

