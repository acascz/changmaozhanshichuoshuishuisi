import re

# 读取 binlog 解析文件
with open('recovery_000050.sql', 'r', encoding='utf-8') as f:
    content = f.read()

# 提取所有 INSERT 语句
insert_pattern = r'(### INSERT INTO .*?)(?=### INSERT|### UPDATE|### DELETE|# at \d+|$)'
matches = re.findall(insert_pattern, content, re.DOTALL)

# 生成恢复 SQL 文件
with open('recovery_data.sql', 'w', encoding='utf-8') as out:
    out.write("-- 数据恢复脚本\n")
    out.write("-- 从 binlog 恢复被删除的数据\n\n")
    out.write("USE mung_bean_cake_mall;\n\n")
    out.write("SET FOREIGN_KEY_CHECKS = 0;\n\n")
    
    for match in matches:
        # 解析 INSERT 语句
        lines = match.strip().split('\n')
        table_name = None
        values = {}
        
        for line in lines:
            line = line.strip()
            if line.startswith('### INSERT INTO'):
                table_name = line.replace('### INSERT INTO ', '').strip()
            elif line.startswith('###   @'):
                # 解析字段值
                parts = line.split('###   @', 1)
                if len(parts) > 1:
                    field_parts = parts[1].split('=', 1)
                    if len(field_parts) == 2:
                        field_num = int(field_parts[0])
                        value = field_parts[1].strip()
                        values[field_num] = value
        
        if table_name and values:
            out.write(f"-- {table_name}\n")
            out.write(f"-- Values: {values}\n\n")
    
    out.write("\nSET FOREIGN_KEY_CHECKS = 1;\n")

print("恢复脚本已生成：recovery_data.sql")
