import re

# 读取 binlog 文件
with open('recovery_rows.sql', 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

output_lines = []
output_lines.append("-- 数据恢复脚本")
output_lines.append("-- 从 binlog 恢复被删除的数据")
output_lines.append("-- 注意：此脚本由 binlog 自动生成，部分编码可能不正确")
output_lines.append("")
output_lines.append("USE mung_bean_cake_mall;")
output_lines.append("SET FOREIGN_KEY_CHECKS = 0;")
output_lines.append("")

# 使用正则表达式提取所有 INSERT 语句
# 模式：### INSERT INTO + 表名 + ### SET + 多行字段值
pattern = r'### INSERT INTO `([^`]+)`\.`([^`]+)`\s*\n### SET\s*\n((?:###\s+@\d+=.*\n)*)'

matches = re.findall(pattern, content)

insert_count = 0
for match in matches:
    db_name = match[0]
    table_name = match[1]
    values_block = match[2]
    
    # 解析字段值
    value_lines = values_block.strip().split('\n')
    values = {}
    for line in value_lines:
        line = line.strip()
        if line.startswith('###'):
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
            output_lines.append(f"INSERT INTO `{table_name}` ({field_str}) VALUES ({value_str});")
            insert_count += 1

output_lines.append("")
output_lines.append("SET FOREIGN_KEY_CHECKS = 1;")

# 写入输出文件
with open('recovery_manual.sql', 'w', encoding='utf-8') as f:
    f.write('\n'.join(output_lines))

print(f"已生成恢复脚本：recovery_manual.sql")
print(f"共生成 {insert_count} 条 INSERT 语句")
