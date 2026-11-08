import sys

sys.stdout.reconfigure(encoding='utf-8')
path = r'backend\src\test\java\group03\magisound\authentication\service\AdminStaffServiceTest.java'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace('ReflectionTestUtils.setField(staffProfile, "id", 20L);',
                          'ReflectionTestUtils.setField(staffProfile, "userId", 20L);')

with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
print('Fixed AdminStaffServiceTest.java')
