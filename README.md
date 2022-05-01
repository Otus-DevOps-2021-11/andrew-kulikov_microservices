## Homework 17


### Доп задание 1. Разбор еще одного формата логов

Для разбора логов запросов был составлен следующий паттерн:
```
service=%{WORD:service} \| event=%{WORD:event} \| path=%{GREEDYDATA:path} \| request_id=%{UUID:request_id} \| remote_addr=%{IP:remote_addr} \| method= %{WORD:method} \| response_status=%{INT:response_status}
```
Также указываем, что необходимо удалить исходное поле в случае успешного сопоставления. Это делаем с помощью флага `remove_key_name_field true`.

Итоговый вид фильтра:
```
<filter service.ui>
  @type parser
  format grok
  key_name message
  reserve_data true
  remove_key_name_field true
  <parse>
    @type grok
    grok_pattern service=%{WORD:service} \| event=%{WORD:event} \| path=%{GREEDYDATA:path} \| request_id=%{UUID:request_id} \| remote_addr=%{IP:remote_addr} \| method= %{WORD:method} \| response_status=%{INT:response_status}
  </parse>
</filter>
```
