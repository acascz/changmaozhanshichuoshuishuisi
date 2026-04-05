# 读取 binlog 文件
$content = Get-Content "binlog_000046.sql" -Encoding UTF8 -Raw

# 提取所有 INSERT 语句
$lines = $content -split "`n"
$output = @()
$output += "-- 用户表和商品表数据恢复脚本"
$output += "-- 从 binlog 000046 恢复"
$output += ""
$output += "USE mung_bean_cake_mall;"
$output += "SET FOREIGN_KEY_CHECKS = 0;"
$output += ""

$currentTable = $null
$currentValues = @{}
$inInsert = $false

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i].Trim()
    
    if ($line -like "### INSERT INTO `mung_bean_cake_mall`.`user`") {
        $currentTable = "user"
        $currentValues = @{}
        $inInsert = $true
    }
    elseif ($line -like "### INSERT INTO `mung_bean_cake_mall`.`product`") {
        $currentTable = "product"
        $currentValues = @{}
        $inInsert = $true
    }
    elseif ($inInsert -and $line -like "###   @*") {
        $parts = $line -split "=", 2
        if ($parts.Count -eq 2) {
            $fieldNum = [int]($parts[0] -replace "###\s+@", "")
            $value = $parts[1].Trim()
            $currentValues[$fieldNum] = $value
        }
    }
    elseif ($inInsert -and ($line -eq "" -or $line -like "### INSERT INTO*" -or $line -like "# at *")) {
        if ($currentTable -and $currentValues.Count -gt 0) {
            # 生成 INSERT 语句
            $fields = @()
            $values = @()
            for ($j = 1; $j -le $currentValues.Count; $j++) {
                if ($currentValues.ContainsKey($j)) {
                    $fields += "col_$j"
                    $val = $currentValues[$j]
                    if ($val -eq "NULL") {
                        $values += "NULL"
                    }
                    elseif ($val -match "^\d+$") {
                        $values += $val
                    }
                    else {
                        $escapedVal = $val -replace "'", "''"
                        $values += "'$escapedVal'"
                    }
                }
            }
            
            if ($fields.Count -gt 0) {
                $fieldStr = $fields -join ", "
                $valueStr = $values -join ", "
                $output += "INSERT INTO `$currentTable` ($fieldStr) VALUES ($valueStr);"
            }
        }
        
        if ($line -like "### INSERT INTO*") {
            $currentTable = if ($line -like "*`user`") { "user" } else { "product" }
            $currentValues = @{}
            $inInsert = $true
        }
        else {
            $inInsert = $false
            $currentTable = $null
            $currentValues = @{}
        }
    }
}

$output += ""
$output += "SET FOREIGN_KEY_CHECKS = 1;"

# 写入文件
$output | Out-File "recovery_user_product.sql" -Encoding UTF8
Write-Host "已生成恢复脚本：recovery_user_product.sql"
