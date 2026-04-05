import re

# 读取 binlog 文件
with open('binlog_000046.sql', 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

output = []
output.append("-- 用户表和商品表数据恢复脚本")
output.append("-- 从 binlog 000046 恢复")
output.append("")
output.append("USE mung_bean_cake_mall;")
output.append("SET FOREIGN_KEY_CHECKS = 0;")
output.append("")

# 使用正则表达式提取所有 INSERT 语句
# 模式：### INSERT INTO + 表名 + ### SET + 多行字段值
pattern = r'### INSERT INTO `mung_bean_cake_mall`\.`(user|product)`\s*\n### SET\s*\n((?:###\s+@\d+=.*\n)*)'

matches = re.findall(pattern, content)

insert_count = 0
for match in matches:
    table_name = match[0]
    values_block = match[1]
    
    # 解析字段值
    value_lines = values_block.strip().split('\n')
    values = {}
    for line in value_lines:
        line = line.strip()
        field_match = re.match(r'###\s+@(\d+)=(.*)', line)
        if field_match:
            field_num = int(field_match.group(1))
            value = field_match.group(2).strip()
            values[field_num] = value
    
    # 生成 INSERT 语句
    if values:
        fields = []
        sql_values = []
        for i in range(1, max(values.keys()) + 1):
            if i in values:
                fields.append(f'col_{i}')
                val = values[i]
                if val == 'NULL':
                    sql_values.append('NULL')
                elif val.isdigit() or (val.startswith('-') and val[1:].isdigit()):
                    sql_values.append(val)
                else:
                    # 字符串，需要加引号并转义
                    escaped_val = val.replace("'", "''")
                    sql_values.append(f"'{escaped_val}'")
        
        if fields and sql_values:
            field_str = ', '.join(fields)
            value_str = ', '.join(sql_values)
            output.append(f"INSERT INTO `{table_name}` ({field_str}) VALUES ({value_str});")
            insert_count += 1

output.append("")
output.append("SET FOREIGN_KEY_CHECKS = 1;")

# 写入输出文件
with open('recovery_user_product.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(output))

print(f"已生成恢复脚本：recovery_user_product.sql")
print(f"共生成 {insert_count} 条 INSERT 语句")
