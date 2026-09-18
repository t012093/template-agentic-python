# learnings.md - Knowledge & Anti-Pattern Log

このファイルは、開発中に発生したエラー・手戻り・バグの根本原因と、「次回以降の再発を100%防ぐための1行ルール」を記録・永続化するログです。

---

## 規約ルール
1. トラブルや失敗が発生した場合、解決時に必ずこのファイルに追記すること。
2. エージェントはタスク着手時にこのファイルを読み込み、過去の過ちを繰り返さないこと。

---

## 学習ログ一覧

- [2026-09-17] [Shell] シェルコマンドへのコード直渡し（cat << 'EOF' 等）はバッククォート置換事故を起こすため、必ず専用書き込みツールを使用すること。
- [2026-09-17] [Test] テストはステータスコードの検証にとどまらず、レスポンスの JSON スキーマ・契約まで検証すること。
- [2026-09-17] [Types] Mypy Strict 環境下では、テスト関数にも戻り値型（-> None）を注釈し、Optional 戻り値の None アサートを怠らないこと。
- [2026-09-17] [Benchmark] ベンチマークテスト（pytest-codspeed）は `-m "not benchmark"` で通常テストから分離し、高速TDDサイクル（1秒未満）を維持すること。
- [2026-09-18] [CI/SpaghettiGuard] Spaghetti Guard (pytestarch) は仮想環境の pytest を呼び出すため、CI では `echo "$GITHUB_WORKSPACE/.venv/bin" >> $GITHUB_PATH` で仮想環境を PATH に追加すること。
- [2026-09-18] [PyTestArch] pytestarch の境界テストでは、ディレクトリプレフィックスに依存しない `have_name_matching(".*<module>")` を使用すること。
- [2026-09-18] [CI/CodSpeed] テンプレートリポジトリの CodSpeed CI は、未連携リポジトリでの 401 失敗を防ぐため `continue-on-error: true` を設定すること。
